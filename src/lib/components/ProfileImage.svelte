<script lang="ts">
	// This component imports SVG with animations and tiling
	import { onMount, onDestroy } from 'svelte';
	
	let containerElement: HTMLDivElement;
	let svgHeight = 0;
	let containerHeight = 0;
	let tiles = 1;
	let svgContent = '';
	
	// Blinking animation
	let blinkTimeouts: number[] = [];
	let blinkKeys: number[] = []; // Array of reactive variables for each tile
	let minPause = 3; // Minimum pause between blinks in seconds
	let maxPause = 10; // Maximum pause between blinks in seconds
	
	// Generate random blink interval
	function getRandomBlinkInterval(): number {
		return Math.random() * (maxPause - minPause) + minPause;
	}
	
	// Set up blinking animation for a specific tile
	function setupBlinkingForTile(tileIndex: number) {
		const randomInterval = getRandomBlinkInterval();
		
		// Set CSS custom property for this specific tile
		document.documentElement.style.setProperty(`--blink-interval-${tileIndex}`, `${randomInterval}s`);
		
		// Clear any existing timeout for this tile
		if (blinkTimeouts[tileIndex]) {
			clearTimeout(blinkTimeouts[tileIndex]);
		}
		
		// Set up timeout to regenerate animation with new random interval
		blinkTimeouts[tileIndex] = setTimeout(() => {
			// Force re-render by updating reactive variable for this tile
			blinkKeys[tileIndex] = blinkKeys[tileIndex] + 1;
			// Set up next random interval for this tile
			setupBlinkingForTile(tileIndex);
		}, randomInterval * 1000);
	}
	
	// Set up blinking for all tiles
	function setupBlinking() {
		// Clear all existing timeouts
		blinkTimeouts.forEach(timeout => clearTimeout(timeout));
		blinkTimeouts = [];
		blinkKeys = [];
		
		// Initialize blink keys for each tile
		for (let i = 0; i < tiles; i++) {
			blinkKeys[i] = 0;
			setupBlinkingForTile(i);
		}
	}
	
	onMount(async () => {
		// Load the SVG content
		try {
			const response = await fetch('/profile.svg');
			svgContent = await response.text();
		} catch (error) {
			console.error('Failed to load SVG:', error);
		}
		
		const updateTiles = () => {
			if (containerElement) {
				// Get the height of the about me section (right side content)
				const aboutMeSection = document.querySelector('.home-section:last-child');
				const aboutMeHeight = aboutMeSection?.clientHeight || 0;
				
				// Get the height of a single SVG
				const firstSvg = containerElement.querySelector('svg');
				if (firstSvg) {
					svgHeight = firstSvg.clientHeight;
					
					// Only add tiles if they fit completely within the about me height
					if (aboutMeHeight > 0 && svgHeight > 0) {
						const maxTiles = Math.floor(aboutMeHeight / svgHeight);
						const newTiles = Math.max(1, maxTiles); // At least 1 tile
						
						console.log(`About me height: ${aboutMeHeight}, SVG height: ${svgHeight}, Max tiles: ${maxTiles}, New tiles: ${newTiles}, Current tiles: ${tiles}`);
						
						// Always update tiles and restart blinking if count changed
						if (newTiles !== tiles) {
							tiles = newTiles;
							setupBlinking();
						}
					} else {
						console.log(`Fallback: About me height: ${aboutMeHeight}, SVG height: ${svgHeight}`);
						// Fallback to 1 tile
						if (tiles !== 1) {
							tiles = 1;
							setupBlinking();
						}
					}
				} else {
					console.log('No SVG found in container');
				}
			} else {
				console.log('Container element not found');
			}
		};
		
		// Wait a bit for the layout to settle, then update
		setTimeout(updateTiles, 100);
		// Also try again after a longer delay to ensure layout is fully settled
		setTimeout(updateTiles, 500);
		window.addEventListener('resize', updateTiles);
		
		return () => {
			window.removeEventListener('resize', updateTiles);
		};
	});
	
	onDestroy(() => {
		// Clean up all blinking timeouts
		blinkTimeouts.forEach(timeout => clearTimeout(timeout));
	});
</script>

{#if svgContent}
	<div bind:this={containerElement} class="profile-container">
		{#each Array(tiles) as _, i}
			<div class="profile-tile" key={`tile-${i}-${blinkKeys[i] || 0}`}>
				{@html svgContent}
			</div>
		{/each}
	</div>
{:else}
	<!-- Fallback while loading -->
	<div class="loading-placeholder">Loading...</div>
{/if}

<style>
	.loading-placeholder {
		width: 100%;
		max-width: 35vw;
		display: flex;
		align-items: center;
		justify-content: center;
		background-color: #f0f0f0;
		border-radius: 8px;
		color: #666;
		font-size: 14px;
		height: 200px;
	}

	.profile-container {
		width: 100%;
		max-width: 35vw;
		display: flex;
		flex-direction: column;
		overflow: hidden;
		/* Don't set height to 100% - let it size based on content */
	}

	.profile-tile {
		width: 100%;
		flex-shrink: 0;
	}

	:global(.profile-tile svg) {
		width: 100%;
		height: auto;
	}

	/* Natural blink cadence with a brief closed pause - each tile gets its own animation */
	:global(.profile-tile #eyes) {
		transform-box: fill-box; /* make transform-origin use the group's bounds */
		transform-origin: 50% 50%; /* center of the eyes group */
		animation: blink var(--blink-interval-0, 6s) infinite;
	}

	/* Generate CSS for each possible tile (up to 10 tiles) */
	:global(.profile-tile:nth-child(1) #eyes) {
		animation: blink var(--blink-interval-0, 6s) infinite;
	}
	:global(.profile-tile:nth-child(2) #eyes) {
		animation: blink var(--blink-interval-1, 6s) infinite;
	}
	:global(.profile-tile:nth-child(3) #eyes) {
		animation: blink var(--blink-interval-2, 6s) infinite;
	}
	:global(.profile-tile:nth-child(4) #eyes) {
		animation: blink var(--blink-interval-3, 6s) infinite;
	}
	:global(.profile-tile:nth-child(5) #eyes) {
		animation: blink var(--blink-interval-4, 6s) infinite;
	}
	:global(.profile-tile:nth-child(6) #eyes) {
		animation: blink var(--blink-interval-5, 6s) infinite;
	}
	:global(.profile-tile:nth-child(7) #eyes) {
		animation: blink var(--blink-interval-6, 6s) infinite;
	}
	:global(.profile-tile:nth-child(8) #eyes) {
		animation: blink var(--blink-interval-7, 6s) infinite;
	}
	:global(.profile-tile:nth-child(9) #eyes) {
		animation: blink var(--blink-interval-8, 6s) infinite;
	}
	:global(.profile-tile:nth-child(10) #eyes) {
		animation: blink var(--blink-interval-9, 6s) infinite;
	}

	/* Keep strokes from getting fat/skinny during the blink (optional) */
	:global(#eyes),
	:global(#eyes *) {
		vector-effect: non-scaling-stroke;
	}

	@keyframes blink {
		0% {
			transform: scaleY(1);
		}
		2% {
			transform: scaleY(0.1);
		} /* close quickly */
		4% {
			transform: scaleY(1);
		} /* open */
		48% {
			transform: scaleY(1);
		} /* idle */
		50% {
			transform: scaleY(0.1);
		} /* a second blink in the cycle */
		52% {
			transform: scaleY(1);
		}
		100% {
			transform: scaleY(1);
		}
	}

	/* Respect reduced motion preferences */
	@media (prefers-reduced-motion: reduce) {
		:global(#eyes) {
			animation: none;
		}
	}
</style>