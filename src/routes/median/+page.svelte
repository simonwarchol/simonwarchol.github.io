<script>
    export let data;
    import 'perlin-contours-rs';
    import { onMount } from 'svelte';
    import { init } from 'perlin-contours-rs';
    console.log('data', data);
    let canvas;
    let scores = data.scores;
    import _ from 'lodash';

    // Reverse list
    scores = scores.reverse();

    onMount(async () => {
        if (navigator.gpu) {
            try {
                console.log('on mount');
                await init(canvas).catch((error) => {
                    if (!error.message.startsWith('Using exceptions for control flow,')) {
                        throw error;
                    }
                });
            } catch (error) {
                console.error(error);
            }
        }
    });
</script>

<canvas bind:this={canvas} />

<h1>Projected Scores</h1>

<div>
    {#each data.scores as score, i}
        <div style="display: flex; justify-content: space-between;">
            <p style="color: hsl({score.matchup * 60}, 100%, 50%)">{score.team}</p>
            <p style="color: hsl({score.matchup * 60}, 100%, 50%)">{_.round(score.proj,2)}</p>
        </div>
        <!-- Check this is the median score -->
        {#if i === data.scores.length / 2 - 1}
            <div style="display: flex; justify-content: space-between; background-color: white; color: black; padding: 2px;">
                <p>Median</p>
                <p>{_.round(data.median,2)}</p>
            </div>
        {/if}
    {/each}
</div>

<style lang="scss">
    h1{
        text-align: center;
        font-size:large;
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
</style>
