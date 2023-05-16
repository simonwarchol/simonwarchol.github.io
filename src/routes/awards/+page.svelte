<script lang="ts">

    import {PortfolioTitle} from '$lib/params';
    import {useTitle} from '$lib/utils';
    import MainTitle from "$lib/components/MainTitle/MainTitle.svelte";
    import Card from "$lib/components/Card/Card.svelte";
    import CardTitle from "$lib/components/Card/CardTitle.svelte";

    const title = 'Awards';

    const awards = [
        {
            title: 'Harvard University Certificate of Distinction in Teaching',
            date: 'Fall 2021',
            course: 'CS171: Visualization',
            link: 'https://www.cs171.org/2021/',
            teaser: '/bok.jpg',
            award_link: 'https://bokcenter.harvard.edu/files/shadowbok/files/fall_2021_distinction_by_course.pdf'
        }, {
            title: 'Harvard University Certificate of Distinction in Teaching',
            date: 'Spring 2021',
            course: 'CS205: Computing Foundations for Computational Science',
            link: 'https://harvard-iacs.github.io/2021-CS205/',
            teaser: '/bok.jpg',
            award_link: 'https://bokcenter.harvard.edu/files/shadowbok/files/spring_2021_distinction_by_name.pdf'
        }, {
            title: 'Harvard University Certificate of Distinction in Teaching',
            date: 'Fall 2020',
            course: 'CS107: Systems Development for Computational Science',
            link: 'https://harvard-iacs.github.io/2020-CS107',
            teaser: '/bok.jpg',
            award_link: 'https://bokcenter.harvard.edu/files/shadowbok/files/fall_2020_distinction_by_course.pdf'
        }
    ]


</script>


<svelte:head>
    <title>{useTitle(title, PortfolioTitle)}</title>
</svelte:head>
<div class="awards-wrapper">
    <MainTitle>{title}</MainTitle>
    <div class="award-awards">
        {#each awards as award}
            <Card margin="0px 0px 20px 0px" tiltDegree={2}>
                <div class="award">
                    <div class="award-teaser">
                        <a href={award?.award_link} target="_blank">
                            <img class="teaser" src={award.teaser}/>
                        </a>
                    </div>
                    <div class="award-data">
                        <a href={award.award_link} target="_blank">
                            <h3 class="award-title">
                                <CardTitle title={award.title}/>
                                <div class="award-title-divider"/>
                            </h3>
                        </a>
                        <div>{award.course}</div>
                        <div class="award-date">{award.date}</div>
                        <div class="award-link">
                            <a href="{award.link}" target="_blank" rel="noopener noreferrer"
                               class="award-link">
                                {award.link}
                            </a>
                        </div>
                    </div>
                </div>
            </Card>
        {/each}
    </div>
</div>

<style lang="scss">
  .awards-wrapper {
    display: flex;
    flex-direction: column;
  }

  .award {
    display: flex;
    align-items: center;


    &-awards {
      display: flex;
      flex-direction: column;
      margin-top: 40px;
    }


    &-data {
      display: flex;
      flex-direction: column;
      margin-left: 20px;
    }

    .teaser {
      height: auto;
      min-width: 100px;
      max-width: 100px;
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
