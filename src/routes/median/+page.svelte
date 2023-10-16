<script>
	import { onMount } from 'svelte';
	import { init } from 'perlin-contours-rs';
	import _ from 'lodash';

	export let data;
	let scores = data.scores;
	let sortByProj = true; // state variable to track sorting mode
	let canvas;

	// Ensure your data object has these properties
	// data = {
	//     scores: [...],
	//     proj_median: ...,
	//     current_median: ...
	// };

	const sortScores = () => {
		// use lodash to sort by the current mode
		if (sortByProj) {
			scores = _.orderBy(scores, ['proj'], ['desc']); // or 'asc' for ascending order
		} else {
			scores = _.orderBy(scores, ['current'], ['desc']); // or 'asc' for ascending order
		}
	};

	const toggleSort = () => {
		sortByProj = !sortByProj; // toggle the state variable
		sortScores(); // re-sort the scores
	};

	// Initial sort
	sortScores();

	onMount(async () => {
		if (navigator.gpu) {
			try {
				console.log('on mount');
				await init(canvas);
			} catch (error) {
				console.error(error);
			}
		}
	});
</script>

<svelte:head>
	<title>Median</title>
</svelte:head>

<canvas bind:this={canvas} />

<h1>Median Scores</h1>

<!-- Button to toggle sorting mode -->
<button on:click={toggleSort}>
	{sortByProj ? 'Sort by Current Score' : 'Sort by Projected Score'}
</button>

<div>
	{#each scores as score, i}
		<div style="display: flex; justify-content: space-between;">
			<p style="color: hsl({score.matchup * 60}, 100%, 50%)">{score.team}</p>
			<p style="color: hsl({score.matchup * 60}, 100%, 50%)">
				{_.round(score.current, 2)} - {_.round(score.proj, 2)}
			</p>
		</div>
		<!-- Check this is the median score -->
		{#if i === scores.length / 2 - 1}
			<div
				style="display: flex; justify-content: space-between; background-color: white; color: black; padding: 2px;"
			>
				<p>Median</p>
				<!-- Display the median based on the current sort mode -->
				<p>{_.round(data.current_median, 2)} - {_.round(data.proj_median, 2)}</p>
			</div>
		{/if}
	{/each}
</div>

<style lang="scss">
	h1 {
		text-align: center;
		font-size: large;
	}
	canvas {
		position: fixed;
		top: 0;
		left: 0;
		width: 100vw !important;
		height: 100vh !important;
		z-index: -1;
	}
	// hide nav-menu
	.nav-menu {
		display: none;
	}
	button {
		display: block;
		margin: 20px auto;
		padding: 10px 20px;
		// Additional styling for the button
	}
</style>
