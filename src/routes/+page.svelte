<script lang="ts">
    import Portrait from '$lib/components/Portrait.svelte';
    import Icon from '$lib/components/Icon/Icon.svelte';
    import {PortfolioTitle} from '$lib/params';
    import type {SocialLink, SocialMedia} from '$lib/utils';
    import {useSocialMedia, useTitle} from '$lib/utils';
    import {isBlank} from '@riadh-adrani/utility-js';

    const title = '';



    const _links = {
        twitter: 'https://twitter.com/simonwarchol',
        googlescholar: 'https://scholar.google.com/citations?user=ZawMTogAAAAJ&hl=en&oi=ao',
        github: 'https://github.com/simonwarchol',
        email: 'simonwarchol@g.harvard.edu'
    }


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
<div class="home">
    <Portrait/>
    <div class="home-section">
        <h1 class="home-title">Simon Warchol</h1>
        <div class="home-subtitle">
            <span class="home-detail">PhD Student in Computer Science at Harvard University</span>
            <span class="home-detail">Advised by <a class="advisors"
                                                    href="https://vcg.seas.harvard.edu/people/hanspeter-pfister">Hanspeter Pfister</a> and co-advised by <a
                    class="advisors" href="https://sysbio.med.harvard.edu/peter-sorger">Peter Sorger</a>.</span>
            <span class="home-detail">My research focuses on <span class="emphasis">visual analytics</span> and <span
                    class="emphasis">visualization</span> for <span class="emphasis">cancer biology</span>.</span>
            <span class="home-detail">Member of <a class="groups" href="https://harvardgradunion.org/">HGSU/UAW Local 5118</a>, <a
                    class="groups" href="https://vcg.seas.harvard.edu/">Visual Computing Group</a>, and the <a
                    class="groups" href="https://labsyspharm.org/">Laboratory of Systems Pharmacology</a>.</span>
            <span class="home-detail">I was raised in <span class="cities">St. Louis, MO</span> and now live in <span
                    class="cities">Cambridge, MA</span>.</span>
            <span class="home-detail">I have some other interests. They include:</span>
        </div>
        <ul class="interests-list">
            <li>Sad Indie Music: <a href="https://www.youtube.com/watch?v=96wDhimQ6nw&amp;t=811s">boygenius</a> and its
                members(<a href="https://www.youtube.com/watch?v=3y00ftsaNiA&amp;t=178s">¹</a> <a
                        href="https://www.youtube.com/watch?v=WJ9-xN6dCW4">²</a> <a
                        href="https://www.youtube.com/watch?v=ZuGa4_4YB4o">³</a>), <a
                        href="https://www.youtube.com/watch?v=eEe_yCVLQSc">The National</a>, <a
                        href="https://www.youtube.com/watch?v=9FX34TjJe-c&amp;t=488s">Sufjan Stevens</a>, <a
                        href="https://www.youtube.com/watch?v=Su-N-iH8CgI">Destroyer</a></li>
            <li>Beer: <a href="https://lamplighterbrewing.com/">Lamplighter</a>, <a
                    href="https://vitaminseabrewing.com/">Vitamin Sea</a>, <a
                    href="https://www.sideprojectbrewing.com/">Side Project</a>, <a
                    href="https://oxbowbeer.com/">Oxbow</a></li>
            <li><a href="https://www.megunticook.org/">Lake Megunticook</a></li>
            <li>My 2009 Prius</li>
        </ul>

        <div class="home-social">
            {#each links as link}
                <a class="home-social-item" href={`${isEmail(link.to) ? 'mailto:' : ''}${link.to}`} target="_blank"
                   rel="noreferrer">
                    <Icon icon={link.icon}/>
                </a>
            {/each}
        </div>

    </div>

</div>

<!--https://coolors.co/76b1e2-962b34-59cd90-fac05e-f79d84   -->
<style lang="scss">
  .home-detail {
    display: block;
    margin-bottom: 1em;
  }

  a.advisors {
    color: #76b1e2;
  }

  .interests-list {
    list-style: square;
    margin-left: 30px;

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


  span.cities {
    //color: #d23742;
    //color: #d23742;
  }

  .home {
    align-self: center;
    display: flex;
    flex-direction: row;
    flex: 1;
    align-self: stretch;
    align-items: center;
    padding: 0px 10px;

    &-title {
      font-family: var(--title-f);
      font-size: 4em;
      font-weight: 900;
      letter-spacing: 2px;
    }

    &-subtitle {
      font-size: 1.2em;
      font-weight: 200;
    }

    &-section {
      display: flex;
      flex-direction: column;
      flex: 1;
    }

    &-social {
      padding: 15px 0px;

      &-item {
        margin-right: 10px;
        text-decoration: none;
      }
    }

    @media (max-width: 875px) {
      & {
        flex-direction: column;
        justify-content: center;
      }

      &-section {
        flex: 0;
        align-items: center;
        text-align: center;
      }
    }
  }
</style>
