<script setup>
const props = defineProps({ top: Boolean });
</script>

<template>
  <div
    class="row q-px-none section-header justify-center relative-position"
    :class="props.top ? '' : 'q-mt-lg'"
  >
    <div class="text-center q-my-auto"><slot></slot></div>

    <!-- More info -->
    <template v-if="$slots.moreInfo">
      <q-icon
        name="help"
        class="absolute-right help"
        style="top: 10px; right: 0"
        size="xs"
      >
        <q-tooltip class="text-body2" anchor="bottom left"
          ><slot name="moreInfo"></slot
        ></q-tooltip>
      </q-icon>
    </template>
  </div>
</template>

<style lang="scss">
@import "../../quasar-variables.sass";

.help {
  color: $light-text;
}
</style>
