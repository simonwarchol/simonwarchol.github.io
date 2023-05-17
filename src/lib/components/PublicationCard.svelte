<script lang="ts">
    import type {Experience} from '$lib/utils';
    import Card from './Card/Card.svelte';
    import CardTitle from './Card/CardTitle.svelte';

    export let experience: Experience;

    const splitAuthors = experience?.authors?.split(',').map(author => author.trim()) || []


</script>

<Card margin="0px 0px 20px 0px" tiltDegree={2}>
    <div class="experience">
        <div class="experience-teaser">
            <a href={experience.vcg_link} target="_blank">
                <img class="teaser" src={experience.teaser}/>
            </a>
        </div>

        <div class="experience-data">
            <a href={experience.vcg_link} target="_blank">
                <h3 class="experience-title">
                    <CardTitle title={experience.title}/>
                    <div class="experience-title-divider"/>
                </h3>
            </a>
            <div class="experience-authors">
                {#each splitAuthors as author}
                    <span class={author === 'Simon Warchol'? 'me' : ''}>{author}{author !== splitAuthors[splitAuthors.length - 1] ? ', ' : '' }</span>
                {/each}
            </div>
            <div class="experience-journal">{experience.journal}</div>
            <div class="experience-link">
                <a href="{experience.link}" target="_blank" rel="noopener noreferrer" class="experience-link">
                    {experience.link}
                </a>
            </div>
        </div>
    </div>
</Card>

<style lang="scss">
  .teaser {
    //width: 600px;
    height: auto;
    min-width:300px;
    max-width: 300px;
  }

  .me {
    color: #d23742;
    font-weight: 600;
  }

  .experience-link {
    color: #76b1e2;
  }

  .experience {
    display: flex;
    align-items: center;

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
    &-journal {
      color: var(--accent-text-c);
      margin-bottom: 0px;
    }

    &-link {
      margin-bottom: 0;
    }


    &-authors {
      margin-bottom: 5px;
    }

    &-journal {
      margin-bottom: 5px;
    }

  }
</style>
