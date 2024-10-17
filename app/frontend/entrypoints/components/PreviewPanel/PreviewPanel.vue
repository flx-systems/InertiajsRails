<template>
  <q-card
    style="min-height: 700px"
    class="q-mx-lg q-mb-lg"
    @drop="fields.length < 1 ? drop($event) : () => {}"
    @dragover.prevent
    @dragenter.prevent
  >
    <!-- Form Title -->
    <q-card-section class="q-pb-none q-mb-none">
      <div
        class="text-left text-bold text-h5 q-mb-none q-pb-none q-pt-lg q-pl-md"
      >
        {{ formTitle }}
      </div>
      <hr class="q-mb-none" />
    </q-card-section>

    <!-- Field List -->
    <q-card-section>
      <div class="row">
        <div
          style="position: relative"
          v-for="(component, index) in fields"
          :key="index"
          :class="`col-${component.width}`"
        >
          <!-- Field View -->
          <preview-item
            :field="component"
            :is-child="childFields.includes(component.referenceId)"
            :selected="index === targetFieldIndex"
            :index="index"
            class="q-mx-sm q-my-sm"
            @click.prevent="targetField(index)"
            @drag-start="onDragPreview(index)"
            @drag-end="onDropPreview(index)"
            @drop="dropOnField(index)"
          ></preview-item>
          <!-- Delete -->
          <q-btn
            icon="delete"
            color="red"
            round
            flat
            size="8px"
            class="absolute-top-right"
            style="top: 8px; right: 20px"
            @click.prevent="deleteField(index)"
          ></q-btn>
        </div>
      </div>
    </q-card-section>

    <!-- Drop Zone -->
    <q-card-section class="drop-here">
      <div
        class="row flex-center text-center q-mb-md q-mt-none q-pt-none q-mx-lg"
        :class="showDropOff ? 'dropoff-show' : 'dropoff-hide'"
        style="min-height: 150px; border: 3px dotted; border-radius: 12px"
        @drop="drop"
      >
        <div class="q-my-auto text-bold text-h6">Drop Here</div>
      </div>
    </q-card-section>
  </q-card>
</template>

<script setup>
import PreviewItem from "../../components/PreviewPanel/PreviewItem.vue";
import { ref, toRaw } from "vue";

const props = defineProps({
  fields: Array,
  childFields: Array,
  formTitle: String,
  targetFieldIndex: Number,
  showDropOff: Boolean,
});
const emit = defineEmits([
  "dragDrop",
  "target",
  "delete-field",
  "move-field-to-position",
]);
const draggingPreviewItem = ref(false);
const draggingPreviewIndex = ref(null);

// Called whenever an existing field is being drug
function onDragPreview(index) {
  draggingPreviewItem.value = true;
  draggingPreviewIndex.value = index;
}

// Called whenever an existing field is being dropped
function onDropPreview(index) {
  draggingPreviewItem.value = false;
  draggingPreviewIndex.value = null;
}

// This is called for dragging the first field onto the empty form and never again. Very useful
function drop(event) {
  emit("dragDrop", props.fields.length);
}

// Tells parent to move currently drug field to the new position. If no dragging preview, it adds a field at that spot
function dropOnField(index) {
  // Shuffling order of existing fields
  if (draggingPreviewItem.value === true) {
    emit("move-field-to-position", draggingPreviewIndex.value, index);
    return;
  }

  // Adding new field
  emit("dragDrop", index);
}

// Called whenever a field is selected and needs to be targetted
function targetField(index) {
  emit("target", index);
}

// Field was deleted
function deleteField(index) {
  emit("delete-field", index);
}
</script>

<style scoped lang="scss">
@import "../../quasar-variables.sass";
hr {
  color: $light-text;
}

.drop-here {
  transform: scale(1.05, 1.05);
}

.dropoff-show {
  height: 25px;
  color: $primary;
  border-color: $primary;
  transition: 0.2s ease-in-out;
}

.dropoff-hide {
  transform: scale(0.5, 0.5);
  color: white;
}
</style>
