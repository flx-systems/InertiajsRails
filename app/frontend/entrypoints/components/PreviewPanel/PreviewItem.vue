<template>
  <!-- Main Card -->
  <q-card
    flat
    bordered
    style="min-height: 100px; height: 90%"
    :class="(selected ? 'elevated ' : '') + (isChild ? 'child-field' : '')"
    draggable="true"
    @dragstart="onDragStart"
    @dragend="onDragEnd"
  >
    <!-- Type icon -->
    <q-icon
      class="absolute-top-left"
      :name="field.icon"
      size="16px"
      color="grey"
      style="left: 6px; top: 4px"
    ></q-icon>

    <!-- Text blocks -->
    <template v-if="field.inputType === 'text_block'">
      <q-card-section
        style="min-height: 100px"
        class="row flex-center items-center full-height text-center q-pb-lg"
        :class="field.text === '' ? 'text-bold text-red' : ''"
      >
        <!-- Header -->
        <template v-if="field.header">
          <div
            class="text-left text-bold text-h5 q-mb-none q-pb-none q-pt-lg q-pl-md"
          >
            {{ field.text !== "" ? field.text : "Missing text" }}
          </div>
          <hr class="q-mb-none" style="width: 95%" />
        </template>

        <!-- Normal -->
        <template v-else>
          <div style="white-space: pre-wrap">
            {{ field.text !== "" ? field.text : "Missing text" }}
          </div>
        </template>
      </q-card-section>
    </template>

    <!-- Images -->
    <template v-else-if="field.inputType === 'image'">
      <q-card-section
        style="min-height: 100px"
        :style="`max-height: ${field.height}px`"
        class="row flex-center items-center full-height text-center"
        :class="field.imageSource === '' ? 'text-bold text-red' : ''"
      >
        <!-- Display Image -->
        <q-img
          fit="contain"
          v-if="field.imageSource !== ''"
          :src="field.imageSource"
          style="max-height: 100%"
        ></q-img>

        <!-- Image Missing Text-->
        <div v-else>Missing image</div>
      </q-card-section>
    </template>

    <!-- Fields -->
    <template v-else>
      <!-- Label -->
      <q-card-section class="text-center q-pt-sm q-pb-sm q-mb-none">
        {{ field.label }}
      </q-card-section>

      <!-- Input Field -->
      <q-card-section class="q-pt-none q-mt-none q-mx-md">
        <!-- Default text field -->
        <q-input
          v-if="props.field.inputType === 'text_field'"
          v-model="inputValue"
          outlined
          dense
          disable
          :placeholder="field.placeholder"
        ></q-input>

        <!-- Yes/No -->
        <div v-else-if="props.field.inputType === 'checkbox'">
          <q-list>
            <q-item class="justify-start q-my-none q-py-none">
              <q-radio
                class="q-my-none q-py-none"
                v-model="inputValue"
                val="0"
                label="Yes"
                disable
                style="max-width: 0%"
                size="xs"
              />
            </q-item>
            <q-item class="justify-start q-my-none q-py-none">
              <q-radio
                class="q-my-none q-py-none"
                v-model="inputValue"
                val="1"
                label="No"
                disable
                size="xs"
                style="max-width: 0%"
              />
            </q-item>
          </q-list>
        </div>

        <!-- Select dropdown -->
        <div v-else>
          <q-select
            v-model="labelSelectValue"
            :label-color="props.field.selectOptions?.length <= 0 ? 'red' : ''"
            dense
            disable
            :options="props.field.selectOptions"
            :label="
              props.field.selectOptions.length > 0
                ? props.field.placeholder
                : 'No options provided'
            "
          ></q-select>
        </div>
      </q-card-section>
    </template>

    <!-- Footer Buttons -->
    <q-card-section
      class="row justify-center text-right q-mt-none q-pt-none"
      v-if="props.field.multipleRows || props.field.includePhoto"
    >
      <!-- Include Photo -->
      <q-btn
        class="q-mx-sm"
        v-if="props.field.includePhoto"
        color="primary"
        dense
        icon="photo"
      />

      <!-- Multiple Rows -->
      <q-btn
        class="q-mx-sm"
        v-if="props.field.multipleRows"
        color="primary"
        dense
        v-text="'Add Row +'"
      />
    </q-card-section>
  </q-card>
</template>

<script setup>
import { ref, watch } from "vue";

const emit = defineEmits(["drag-start", "drag-end"]);
const props = defineProps({
  field: Object,
  selected: Boolean,
  isChild: Boolean,
});
const showTop = ref(false);
const showBottom = ref(false);

// This is a useless variable and is only used so the fields have a model
const inputValue = ref("");
const labelSelectValue = ref("");

function onDragStart() {
  emit("drag-start");
}

function onDragEnd() {
  emit("drag-end");
}

function onMouseOver(event) {
  const boundingRect = event.target.getBoundingClientRect();
  const overTop = event.clientY - boundingRect.top < boundingRect.height / 2;
  showTop.value = overTop;
  showBottom.value = !overTop;
}

function onMouseLeave() {
  showTop.value = false;
  showBottom.value = false;
}
</script>

<style scoped lang="scss">
@import "../../quasar-variables.sass";

.elevated {
  transform: scale(105%);
  transition: transform 0.2s ease-in-out;
  border: 2px dashed $primary;
  box-shadow: 0 2px 10px gray !important;
}

.child-field {
  transform: scale(102%);
  transition: transform 0.2s ease-in-out;
  border: 2px solid $secondary;
  box-shadow: 0 0 4px gray !important;
}
</style>
