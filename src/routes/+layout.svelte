<script lang="ts">
    import NavMenu from '$lib/components/NavMenu.svelte';
    import '$lib/index.scss';

</script>

<NavMenu/>
<div class="content container">
    <slot/>
</div>
<div class="footer">
    <h3 class="color-gradient">© 2023 Simon Warchol</h3>
</div>


<style lang="scss">
  canvas {
    position: fixed;
    top: 0;
    left: 0;
    width: 300px;
    height: 300px;
  }
  .footer {
    position: fixed;
    left: 0;
    bottom: 0;
    width: 100%;
    background-color: rgba(0, 0, 0);
    color: white;
    text-align: center;
  }

  .color-gradient {
    background-image: linear-gradient(
                    -225deg,
                    #66c2a5 0%,
                    #fc8d62 29%,
                    #8da0cb 67%,
                    #e78ac3 100%
    );
    background-size: 200% auto;
    color: #fff;
    background-clip: text;
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    animation: textclip 5s linear infinite;
    display: inline-block;
  }

  @keyframes textclip {
    to {
      background-position: 200% center;
    }
  }

  .content {
    display: flex;
    flex-direction: column;
    flex: 1;
    padding: 10px 0px;
  }

  .container {
    max-width: 1200px;
    min-width: 1200px;
    margin: 0px auto;

    @media (max-width: 1350px) {
      & {
        max-width: 1000px;
        min-width: 1000px;
      }
    }

    @media (max-width: 1075px) {
      & {
        max-width: -webkit-fill-available;
        min-width: -webkit-fill-available;
        max-width: -moz-available;
        min-width: -moz-available;
      }
    }
  }

  @media (max-width: 950px) {
    .content {
      padding-left: 15px;
      padding-right: 15px;
    }
  }

  @media (max-width: 750px) {
    .content {
      padding-left: 10px;
      padding-right: 10px;
    }
  }

  :global(body) {
    margin: 0px;
    background-color: var(--primary-c);
    color: var(--primary-text-c);
    font-family: var(--text-f);
    display: flex;
    flex-direction: column;

    letter-spacing: 1px;

    min-height: 100vh;
  }

  :global(p) {
    margin: 0px;
  }

  :global(h1, h2, h3, h4, h5, h6) {
    margin: 5px 0px;
  }
</style>
