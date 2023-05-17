<script lang="ts">
</script>

<div class="profile-wrapper">
    <span id="profile-image" class="profile-image"></span>
</div>

<style lang="scss">
  #profile-image {
    background-image: url("/profile.png");
    width: 600px;
    height: 600px;
    background-size: contain;
    //background-size: auto 100%;
    background-position: center;
    background-repeat:  no-repeat;
  }

  .profile-wrapper {
    flex: 1;
    display: flex;
    justify-content: center;
    align-items: center;

  }
</style>
