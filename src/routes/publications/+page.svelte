<script>
    import ExperienceCard from '$lib/components/PublicationCard.svelte';
    import MainTitle from '$lib/components/MainTitle/MainTitle.svelte';
    import {PortfolioTitle} from '$lib/params';
    import {useTitle} from '$lib/utils';

    const title = 'Publications';
    const items = [
        {
            title: 'Lymphocyte networks are dynamic cellular communities in the immunoregulatory landscape of lung adenocarcinoma',
            authors: 'Giorgio Gaglia, Megan L Burger, Cecily C Ritch, Danae Rammos, Yang Dai, Grace E Crossland, Sara Z Tavana, Simon Warchol, Alex M Jaeger, Santiago Naranjo, Shannon Coy, Ajit J Nirmal, Robert Krueger, Jia-Ren Lin, Hanspeter Pfister, Peter K Sorger, Tyler Jacks, Sandro Santagata',
            journal: 'Cancer Cell 2023 May 8;41(5):871-886.e10',
            link: "https://www.cell.com/cancer-cell/fulltext/S1535-6108(23)00088-0",
            vcg_link: "https://vcg.seas.harvard.edu/publications/lymphocyte-networks",
            teaser: '/fx1_lrg.jpg',
        },{
            title: 'Vimo: Visual Analysis of Neuronal Connectivity Motifs',
            authors: 'Jakob Troidl, Simon Warchol, Jinhan Choi, Jordan Matelsky, Nagaraju Dhanysai, Xueying Wang, Brock Wester, Donglai Wei, Jeff W Lichtman, Hanspeter Pfister, Johanna Beyer',
            journal: 'Pre-Print',
            link: "https://doi.org/10.1101/2022.12.09.519772",
            vcg_link: "https://vcg.seas.harvard.edu/publications/vimo",
            teaser: '/vimo-teaser-02.png',
        },
        {
            title: 'Visinity: Visual Spatial Neighborhood Analysis for Multiplexed Tissue Imaging Data',
            authors: 'Simon Warchol, Robert Krueger, Ajit Johnson Nirmal, Giorgio Gaglia, Jared Jessup, Cecily C Ritch, John Hoffer, Jeremy Muhlich, Megan L Burger, Tyler Jacks, Sandro Santagata, Peter K Sorger, Hanspeter Pfister',
            journal: 'IEEE Transactions on Visualization and Computer Graphics. 2023 Jan; 29(1): 106–116.',
            link: "https://ieeexplore.ieee.org/document/9904770",
            vcg_link: "https://vcg.seas.harvard.edu/publications/visinity",
            teaser: '/interfaceteaserfinalthumbnail.jpg',
        },
        {

            authors: 'Jared Jessup, Robert Krueger, Simon Warchol, John Hoffer, Jeremy Muhlich, Cecily C Ritch, Giorgio Gaglia, Shannon Coy, Yu-An Chen, Jia-Ren Lin, Sandro Santagata, Peter K Sorger, Hanspeter Pfister',
            title: 'Scope2Screen: focus+ context techniques for pathology tumor assessment in multivariate image data',
            journal: 'IEEE Transactions on Visualization and Computer Graphics. 2022 Jan; 28(1): 259–269.',
            link: "https://ieeexplore.ieee.org/document/9557792",
            vcg_link: "https://vcg.seas.harvard.edu/publications/scope2screen",
            teaser: '/scope2screen_high_res.png',
        }
    ]

</script>

<svelte:head>
    <title>{useTitle(title, PortfolioTitle)}</title>
</svelte:head>
<div class="experience">
    <MainTitle>{title}</MainTitle>
    <div class="experience-experiences">
        {#each items as job}
            <ExperienceCard experience={job}/>
        {/each}
    </div>
</div>

<style lang="scss">
  .experience {
    display: flex;
    flex-direction: column;

    &-experiences {
      display: flex;
      flex-direction: column;
      margin-top: 40px;
    }
  }
</style>
