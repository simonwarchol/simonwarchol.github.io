<script lang="ts">
	import Icon from '$lib/components/Icon/Icon.svelte';
	import { PortfolioTitle } from '$lib/params';
	import type { SocialLink, SocialMedia } from '$lib/utils';
	import { useSocialMedia, useTitle } from '$lib/utils';
	import Background from '$lib/components/Background/Background.svelte';
	import _ from 'lodash';
	import ExperienceCard from '$lib/components/PublicationCard.svelte';
	import MainTitle from '$lib/components/MainTitle/MainTitle.svelte';
	import { onMount } from 'svelte';

	const title = '';

	function isBlank(value) {
		return (_.isEmpty(value) && !_.isNumber(value)) || _.isNaN(value);
	}

	const publicationsTitle = 'Publications';
	const items = [
		{
			title:
				'Is What You Ask For What You Get? Investigating Concept Associations in Text-to-Image Models',
			authors:
				'Salma Abdel Magid, Weiwei Pan, Simon Warchol, Grace Guo,Junsik Kim, Mahia Rahman, and Hanspeter Pfister',
			journal: 'arXiv preprint',
			link: 'https://doi.org/10.1111/cgf.15103',
			vcg_link: 'https://doi.org/10.48550/arXiv.2410.04634',
			// teaser: '/psudo_teaser.jpg'
		},
		{
			title:
				'psudo: Exploring Multi-Channel Biomedical Image Data with Spatially and Perceptually Optimized Pseudocoloring',
			authors:
				'Simon Warchol, Jakob Troidl, Jeremy Muhlich, Robert Krueger, John Hoffer, Tica Lin, Johanna Beyer, Elena Glassman, Peter Sorger, and Hanspeter Pfister',
			journal: 'Computer Graphics Forum (EuroVis 24), 43: e15103.',
			link: 'https://doi.org/10.1111/cgf.15103',
			vcg_link: 'https://vcg.seas.harvard.edu/publications/psudo',
			teaser: '/psudo_teaser.jpg'
		},
		{
			title: 'Vimo: Visual Analysis of Neuronal Connectivity Motifs',
			authors:
				'Jakob Troidl, Simon Warchol, Jinhan Choi, Jordan Matelsky, Nagaraju Dhanysai, Xueying Wang, Brock Wester, Donglai Wei, Jeff W Lichtman, Hanspeter Pfister, Johanna Beyer',
			journal: 'IEEE Transactions on Visualization and Computer Graphics',
			link: 'https://doi.org/10.1109/TVCG.2023.3327388',
			vcg_link: 'https://vcg.seas.harvard.edu/publications/vimo',
			teaser: '/vimo-teaser-02.png'
		},
		{
			title: 'Beyond Generating Code: Evaluating GPT on a Data Visualization Course',
			authors:
				'Chen Zhu-Tian, Chenyang Zhang, Qianwen Wang, Jakob Troidl, Simon Warchol, Johanna Beyer, Nils Gehlenborg, Hanspeter Pfiste',
			journal:
				'2023 IEEE VIS Workshop on Visualization Education, Literacy, and Activities (EduVis)',
			link: 'https://doi.org/10.1109/EduVis60792.2023.00009',
			vcg_link:
				'https://vcg.seas.harvard.edu/publications/beyond-generating-code-evaluating-gpt-on-a-data-visualization-course',
			teaser: '/beyond_teaser.png'
		},
		{
			title:
				'Lymphocyte networks are dynamic cellular communities in the immunoregulatory landscape of lung adenocarcinoma',
			authors:
				'Giorgio Gaglia, Megan L Burger, Cecily C Ritch, Danae Rammos, Yang Dai, Grace E Crossland, Sara Z Tavana, Simon Warchol, Alex M Jaeger, Santiago Naranjo, Shannon Coy, Ajit J Nirmal, Robert Krueger, Jia-Ren Lin, Hanspeter Pfister, Peter K Sorger, Tyler Jacks, Sandro Santagata',
			journal: 'Cancer Cell 2023 May 8;41(5):871-886.e10',
			link: 'https://www.cell.com/cancer-cell/fulltext/S1535-6108(23)00088-0',
			vcg_link: 'https://vcg.seas.harvard.edu/publications/lymphocyte-networks',
			teaser: '/fx1_lrg.jpg'
		},

		{
			title: 'Visinity: Visual Spatial Neighborhood Analysis for Multiplexed Tissue Imaging Data',
			authors:
				'Simon Warchol, Robert Krueger, Ajit Johnson Nirmal, Giorgio Gaglia, Jared Jessup, Cecily C Ritch, John Hoffer, Jeremy Muhlich, Megan L Burger, Tyler Jacks, Sandro Santagata, Peter K Sorger, Hanspeter Pfister',
			journal:
				'IEEE Transactions on Visualization and Computer Graphics. 2023 Jan; 29(1): 106–116.',
			link: 'https://ieeexplore.ieee.org/document/9904770',
			vcg_link: 'https://vcg.seas.harvard.edu/publications/visinity',
			teaser: '/interfaceteaserfinalthumbnail.jpg'
		},
		{
			authors:
				'Jared Jessup, Robert Krueger, Simon Warchol, John Hoffer, Jeremy Muhlich, Cecily C Ritch, Giorgio Gaglia, Shannon Coy, Yu-An Chen, Jia-Ren Lin, Sandro Santagata, Peter K Sorger, Hanspeter Pfister',
			title:
				'Scope2Screen: focus+ context techniques for pathology tumor assessment in multivariate image data',
			journal:
				'IEEE Transactions on Visualization and Computer Graphics. 2022 Jan; 28(1): 259–269.',
			link: 'https://ieeexplore.ieee.org/document/9557792',
			vcg_link: 'https://vcg.seas.harvard.edu/publications/scope2screen',
			teaser: '/scope2screen_high_res.png'
		}
	];

	const awardsTitle = 'Awards';

	const awards = [
		{
			title: 'Harvard University Certificate of Distinction in Teaching',
			journal: 'Fall 2021',
			authors: 'CS171: Visualization',
			link: 'https://www.cs171.org/2021/',
			teaser: '/bok.jpg',
			vcg_link:
				'https://bokcenter.harvard.edu/files/shadowbok/files/fall_2021_distinction_by_course.pdf'
		},
		{
			title: 'Harvard University Certificate of Distinction in Teaching',
			journal: 'Spring 2021',
			authors: 'CS205: Computing Foundations for Computational Science',
			link: 'https://harvard-iacs.github.io/2021-CS205/',
			teaser: '/bok.jpg',
			vcg_link:
				'https://bokcenter.harvard.edu/files/shadowbok/files/spring_2021_distinction_by_name.pdf'
		},
		{
			title: 'Harvard University Certificate of Distinction in Teaching',
			journal: 'Fall 2020',
			authors: 'CS107: Systems Development for Computational Science',
			link: 'https://harvard-iacs.github.io/2020-CS107',
			teaser: '/bok.jpg',
			vcg_link:
				'https://bokcenter.harvard.edu/files/shadowbok/files/fall_2020_distinction_by_course.pdf'
		}
	];

	const _links = {
		twitter: 'https://twitter.com/simonwarchol',
		googlescholar: 'https://scholar.google.com/citations?user=ZawMTogAAAAJ&hl=en&oi=ao',
		github: 'https://github.com/simonwarchol',
		email: 'simonwarchol@g.harvard.edu'
	};

	const links: Array<SocialLink> = Object.keys(_links).map((key) => {
		const to = _links[key as 'github'] as string;
		const data = useSocialMedia(key as SocialMedia);

		return {
			to,
			title: data.title,
			icon: data.icon
		};
	});

	const isEmail = (email: string): boolean => {
		const reg =
			/^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|.(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;

		return !isBlank(email) && reg.test(email);
	};
</script>

<svelte:head>
	<title>{useTitle(title, PortfolioTitle)}</title>
</svelte:head>
<Background />
<div class="home" id="home-container">
	<div class="home-section">
		<div id="profile-image" class="profile-image" />
	</div>
	<div class="home-section">
		<h1 class="home-title">Simon Warchol</h1>
		<div class="home-subtitle">
			<span class="home-detail">PhD Candidate in Computer Science at Harvard University.</span>
			<span class="home-detail"
				>Advised by <a class="advisors" href="https://vcg.seas.harvard.edu/people/hanspeter-pfister"
					>Hanspeter Pfister</a
				>
				and co-advised by
				<a class="advisors" href="https://sysbio.med.harvard.edu/peter-sorger">Peter Sorger</a
				>.</span
			>
			<span class="home-detail"
				>My research focuses on <span class="emphasis">visual analytics</span> and
				<span class="emphasis">visualization</span>
				for <span class="emphasis">cancer biology</span>.</span
			>
			<span class="home-detail"
				>Member of
				<a class="groups" href="https://vcg.seas.harvard.edu/">Visual Computing Group</a> and the
				<a class="groups" href="https://labsyspharm.org/">Laboratory of Systems Pharmacology</a
				>.</span
			>

			<span class="home-detail">
				<a class="groups" href="https://harvardgradunion.org/">HGSU/UAW Local 5118</a> Financial Secretary.</span
			>
			<span class="home-detail"
				>I was raised in <span class="cities">St. Louis, MO</span> and now live in
				<span class="cities">Cambridge, MA</span>.</span
			>
			<span class="home-detail">I have some other interests. They include:</span>
		</div>
		<ul class="interests-list">
			<li>
				Sad Indie Music: <a href="https://www.youtube.com/watch?v=UtQlRpZlN-w">Lucy Dacus</a>,
				<a href="https://www.youtube.com/watch?v=uWd0EWKpH94&t=6942s">The National</a>,
				<a href="https://www.youtube.com/watch?v=G7aK0kNhQ20">The Beths</a>,
				<a href="https://www.youtube.com/watch?v=vTZhG9YSY_c">Slowdive</a>,
				<a href="https://www.youtube.com/watch?v=Z_ypVHGa1vM">Destroyer</a>.
			</li>
			<li>
				Local Politics: I am a
				<a href="https://gblc.us/">Greater Boston Labor Council</a> delegate and a voting member of
				the
				<a href="https://uaw.org/regions/uaw-region-9a/">UAW Region 9A</a> Massachusetts CAP Council.
			</li>

			<!-- <li>
				Beer: <a href="https://lamplighterbrewing.com/">Lamplighter</a>,
				<a href="https://vitaminseabrewing.com/">Vitamin Sea</a>,
				<a href="https://www.sideprojectbrewing.com/">Side Project</a>,
				<a href="https://oxbowbeer.com/">Oxbow</a>.
			</li> -->
			<li><a href="https://www.megunticook.org/">Lake Megunticook</a>.</li>
			<li>My 2009 Prius.</li>
		</ul>

		<div class="home-social">
			{#each links as link}
				<a
					class="home-social-item"
					href={`${isEmail(link.to) ? 'mailto:' : ''}${link.to}`}
					target="_blank"
					rel="noreferrer"
				>
					<Icon icon={link.icon} />
				</a>
			{/each}
		</div>
	</div>
</div>
<div class="experience" id="publications-anchor">
	<MainTitle>{publicationsTitle}</MainTitle>
	<div class="experience-experiences">
		{#each items as job}
			<ExperienceCard experience={job} />
		{/each}
	</div>
</div>
<div class="awards-wrapper" id="awards-anchor">
	<MainTitle>{awardsTitle}</MainTitle>
	<div class="award-awards">
		{#each awards as award}
			<ExperienceCard experience={award} />
			<!--            <Card margin="0px 0px 20px 0px" tiltDegree={2}>-->
			<!--                <div class="award">-->
			<!--                    <div class="award-teaser">-->
			<!--                        <a href={award?.award_link} target="_blank">-->
			<!--                            <img class="teaser" src={award.teaser}/>-->
			<!--                        </a>-->
			<!--                    </div>-->
			<!--                    <div class="award-data">-->
			<!--                        <a href={award.award_link} target="_blank">-->
			<!--                            <h3 class="award-title">-->
			<!--                                <CardTitle title={award.title}/>-->
			<!--                                <div class="award-title-divider"/>-->
			<!--                            </h3>-->
			<!--                        </a>-->
			<!--                        <div>{award.course}</div>-->
			<!--                        <div class="award-date">{award.date}</div>-->
			<!--                        <div class="award-link">-->
			<!--                            <a href="{award.link}" target="_blank" rel="noopener noreferrer"-->
			<!--                               class="award-link">-->
			<!--                                {award.link}-->
			<!--                            </a>-->
			<!--                        </div>-->
			<!--                    </div>-->
			<!--                </div>-->
			<!--            </Card>-->
		{/each}
	</div>
</div>

<!--https://coolors.co/76b1e2-962b34-59cd90-fac05e-f79d84   -->
<style lang="scss">
	canvas {
		position: fixed;
		top: 0;
		left: 0;
		width: 100vw !important;
		height: 100vh !important;
		z-index: -1;
	}

	#publications-anchor,
	#awards-anchor {
		padding-top: 50px;
	}

	#home-container {
		padding: 0;
		display: flex;
		flex-direction: row;
		justify-content: center;
		align-content: center;
		overflow: hidden;
	}

	#profile-image {
		background-image: url('/profile.png');
		width: 100%;
		height: 100%;
		//width: 600px;
		//height: 600px;
		max-width: 35vw;
		background-size: contain;
		//background-size: auto 100%;
		background-position: center;
		background-repeat: space;
	}

	.home-section {
		flex-grow: 1;
		width: 100%;
	}

	.home-detail {
		display: block;
		margin-bottom: 0.5em;
	}

	a.advisors {
		color: #76b1e2;
	}

	.interests-list {
		list-style: none;

		a {
			color: #76b1e2;
		}
	}

	a.harvard {
		color: #d23742;
	}

	span.emphasis {
		//color: #59CD90;
		//color: #d23742;
		font-weight: 600;
	}

	a.groups {
		color: #76b1e2;
		//color: #FAC05E;
	}

	.teaser {
		height: auto;
		width: 100px !important;
		min-width: 100px !important;
		max-width: 100px !important;
	}

	span.cities {
		//color: #d23742;
		//color: #d23742;
	}

	.home {
		&-title {
			font-family: var(--title-f);
			font-size: 2.7em;
			font-weight: 900;
			//letter-spacing: 2px;
		}

		&-subtitle {
			font-size: 1.1em;
			font-weight: 200;
		}

		&-section {
			//display: flex;
			//flex-direction: column;
			//flex: 1;
			//overflow: hidden;
		}

		&-social {
			padding: 15px 0px;

			&-item {
				margin-right: 10px;
				text-decoration: none;
			}
		}
	}

	.experience {
		//border-top: gray dashed;
		//margin-top:25px;
		display: flex;
		flex-direction: column;

		&-experiences {
			display: flex;
			flex-direction: column;
		}
	}

	.awards-wrapper {
		//border-top: gray dashed;
		//margin-top:25px;
		display: flex;
		flex-direction: column;
	}

	.award {
		display: flex;
		align-items: center;

		&-awards {
			display: flex;
			flex-direction: column;
		}

		&-data {
			display: flex;
			flex-direction: column;
			margin-left: 20px;
		}

		@media (max-width: 800px) {
			flex-direction: column;

			&-data {
				margin-left: 0px;
			}
		}

		&-title {
			margin: 0;
			display: flex;
			align-items: center;

			&-divider {
				width: 10px;
			}

			@media (max-width: 800px) {
				& {
					align-items: center;
					margin: 5px 0px;
				}
			}
		}

		&-period,
		&-date {
			color: var(--accent-text-c);
			margin-bottom: 0px;
		}

		&-link {
			margin-bottom: 0;
		}

		&-authors {
			margin-bottom: 5px;
		}

		&-date {
			margin-bottom: 5px;
		}
	}

	.projects {
		display: flex;
		flex-direction: column;

		&-search,
		&-filters,
		&-list {
			margin-top: 40px;
		}

		&-search {
			display: flex;
			justify-content: stretch;
			padding: 0px 10px;
		}

		&-list {
			display: grid;
			grid-template-columns: repeat(3, 1fr);
			gap: 20px;
			padding: 0px 10px;

			@media (max-width: 1350px) {
				grid-template-columns: repeat(2, 1fr);
			}
			@media (max-width: 850px) {
				grid-template-columns: repeat(1, 1fr);
			}
		}
	}
</style>
