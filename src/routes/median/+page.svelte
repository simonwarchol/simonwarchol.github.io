<script>
    import { onMount } from 'svelte';
    import { init } from 'perlin-contours-rs';
    import _ from 'lodash';

    export let data;
    let scores = data.scores;
    let sortByProj = true; // default sort
    let canvas;

    const sortScores = () => {
        if (sortByProj) {
            scores = _.orderBy(scores, ['proj'], ['desc']);
        } else {
            scores = _.orderBy(scores, ['current'], ['desc']);
        }
    };

    const toggleSort = (isProj) => {
        sortByProj = isProj;
        sortScores();
    };

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
    <title>Median Scores</title>
</svelte:head>

<canvas bind:this={canvas} />

<h1>Median Scores</h1>

<!-- Create a table structure -->
<table>
    <!-- Table Header -->
    <thead>
        <tr>
            <th>Team Name</th>
            <th on:click={() => toggleSort(false)}>
                Current Score
                {#if !sortByProj}
                    <span>⬇️</span>
                {/if}
            </th>
            <th on:click={() => toggleSort(true)}>
                Projected Score
                {#if sortByProj}
                    <span>⬇️</span>
                {/if}
            </th>
        </tr>
    </thead>
    <!-- Table Body -->
    <tbody>
        {#each scores as score, i}
            <tr>
                <td style="color: hsl({score.matchup * 60}, 100%, 50%)">{score.team}</td>
                <td style="color: hsl({score.matchup * 60}, 100%, 50%)">{_.round(score.current, 2)}</td>
                <td style="color: hsl({score.matchup * 60}, 100%, 50%)">{_.round(score.proj, 2)}</td>
            </tr>
            {#if i === scores.length / 2 - 1}
                <tr style="background-color: white; color: black;">
                    <td>Median</td>
                    <td>{_.round(data.current_median, 2)}</td>
                    <td>{_.round(data.proj_median, 2)}</td>
                </tr>
            {/if}
        {/each}
    </tbody>
</table>

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
    .nav-menu {
        display: none;
    }
    table {
        width: 100%;
        border-collapse: collapse;
        margin: 25px 0;
        font-size: 0.9em;
        min-width: 400px;
        border-radius: 5px 5px 0 0;
        overflow: hidden;
        box-shadow: 0 0 20px rgba(0, 0, 0, 0.15);
        th, td {
            padding: 12px 15px;
            text-align: left;
        }
        th {
            background-color: #009879;
            color: white;
            cursor: pointer; /* make it obvious you can interact with these headers */
        }
        tr {
            border-bottom: 1px solid #dddddd;
        }
        /* Add styles for the arrow */
        th span {
            padding-left: 10px;
        }
    }
</style>
