<script lang="ts">
	import { onMount, onDestroy } from 'svelte';
	import { browser } from '$app/environment';
	import vertShaderCode from './triangle.vert.wgsl?raw';
	import fragShaderCode from './triangle.frag.wgsl?raw';

	let rafHandle: number;
	let canvas: HTMLCanvasElement;
	let adapter: GPUAdapter;
	let startTime: number;
	let randomState = Math.random() * 1000;
	onMount(async () => {
		startTime = performance.now();
		const entry = (navigator as any)?.gpu;
		if (!entry) throw new Error('WebGPU is not supported in this browser.');

		adapter = await entry.requestAdapter();
		if (!adapter) throw new Error("Couldn't request GPU adapter.");

		const device = await adapter.requestDevice();
		if (!device) throw new Error("Couldn't request GPU logical device.");

		const context = canvas.getContext('webgpu');
		if (!context) throw new Error("Couldn't get WebGPU canvas context.");

		const devicePixelRatio = window.devicePixelRatio;
		canvas.width = canvas.clientWidth * devicePixelRatio;
		canvas.height = canvas.clientHeight * devicePixelRatio;
		const presentationFormat = navigator.gpu.getPreferredCanvasFormat();

		context.configure({
			device,
			format: presentationFormat,
			alphaMode: 'premultiplied'
		});

		const bindGroupLayout = device.createBindGroupLayout({
			entries: [
				{
					binding: 0,
					visibility: GPUShaderStage.VERTEX | GPUShaderStage.FRAGMENT, // Include both stages
					buffer: {
						type: 'uniform'
					}
				}
			]
		});

		// Create the pipeline layout
		const pipelineLayout = device.createPipelineLayout({
			bindGroupLayouts: [bindGroupLayout]
		});

		const pipeline = device.createRenderPipeline({
			layout: pipelineLayout,
			vertex: {
				module: device.createShaderModule({
					code: vertShaderCode
				}),
				entryPoint: 'main'
			},
			fragment: {
				module: device.createShaderModule({
					code: fragShaderCode
				}),
				entryPoint: 'main',
				targets: [
					{
						format: presentationFormat
					}
				]
			},
			primitive: {
				topology: 'triangle-list'
			}
		});

		const uniformArray = new Float32Array([0]);
		const uniformBuffer = device.createBuffer({
			size: uniformArray.byteLength,
			usage: GPUBufferUsage.UNIFORM | GPUBufferUsage.COPY_DST
		});

		const uniformBindGroup = device.createBindGroup({
			layout: pipeline.getBindGroupLayout(0),
			entries: [
				{
					binding: 0,
					resource: {
						buffer: uniformBuffer
					}
				}
			]
		});

		function frame() {
			// Update the texture view at the beginning of each frame
			const textureView = context.getCurrentTexture().createView();

			const renderPassDescriptor: GPURenderPassDescriptor = {
				colorAttachments: [
					{
						view: textureView,
						clearValue: [0, 0, 0, 1],
						loadOp: 'clear',
						storeOp: 'store'
					}
				]
			};

			const currentTime = performance.now();
			const elapsedTime = (currentTime - startTime) / 30000; // Convert to seconds

			// Update the uniform based on elapsed time
			uniformArray[0] = elapsedTime + randomState;

			const commandEncoder = device.createCommandEncoder();
			const passEncoder = commandEncoder.beginRenderPass(renderPassDescriptor);
			passEncoder.setPipeline(pipeline);
			passEncoder.setBindGroup(0, uniformBindGroup);
			device.queue.writeBuffer(uniformBuffer, 0, uniformArray);
			passEncoder.draw(6);
			passEncoder.end();
			device.queue.submit([commandEncoder.finish()]);
			rafHandle = requestAnimationFrame(frame);
		}
		requestAnimationFrame(frame);
	});

	onDestroy(() => {
		browser && cancelAnimationFrame(rafHandle);
	});
</script>

<svelte:head>
	<meta name="description" content="WebGPU triangle render example" />
</svelte:head>

<canvas bind:this={canvas} width={640} height={640} />

<style lang="scss">
	canvas {
		position: fixed;
		top: 0;
		left: 0;
		width: 100vw !important;
		height: 100vh !important;
		z-index: -1;
	}
</style>
