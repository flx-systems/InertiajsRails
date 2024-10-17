<template>
  <q-card
    class="justify-center q-my-sm"
    :class="elevated ? 'elevated' : ''"
    style="height: 50px"
    bordered
    :flat="!elevated"
    @mouseenter="elevated = true"
    @mouseleave="elevated = false"
  >
    <q-card-section>
      <div class="row">
        <!-- Icon -->
        <div
          class="col flex items-center justify-center"
          style="min-width: 32px; max-width: 32px"
        >
          <q-icon :name="item.icon" size="18px"></q-icon>
        </div>

        <!-- Name -->
        <div class="col label">
          <div>{{ item.type }}</div>
        </div>
      </div>
    </q-card-section>
  </q-card>
</template>

<script setup>
import { ref } from "vue";

const props = defineProps({ item: Object });
const elevated = ref(false);
</script>

<style scoped lang="scss">
@import "../../quasar-variables.sass";

.label {
  font-size: 12px;
  font-weight: bold;
  color: $dark-text;
}

.elevated {
  transform: scale(105%);
  transition: transform 0.2s ease-in-out;
  border: 2px solid $primary;
}
</style>
