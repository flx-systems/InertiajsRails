<template>
  <div>
    <q-card flat bordered class="q-ml-lg q-mt-lg">
      <!-- Title -->
      <q-card-section class="q-pb-none relative-position">
        <div class="text-bold text-center">Field Types</div>
      </q-card-section>

      <hr />

      <!-- Component List -->
      <q-card-section
        class="q-pt-none"
        style="max-height: 35vh; overflow-y: scroll; overflow-x: hidden"
      >
        <q-list>
          <components-list-item
            v-for="(component, index) in props.components"
            :item="component"
            :key="component.name"
            draggable="true"
            @dragstart="onDragStart(index)"
            @dragend="emit('dragEnd')"
          ></components-list-item>
        </q-list>
      </q-card-section>
    </q-card>

    <q-card flat bordered class="q-ml-lg q-mt-md">
      <!-- Title -->
      <q-card-section class="q-pb-none">
        <div class="text-bold text-center">Form Details</div>
      </q-card-section>

      <hr />
      <!-- Form Info -->
      <q-card-section
        class="q-pt-none"
        style="max-height: 35vh; overflow-y: scroll; overflow-x: hidden"
      >
        <!-- Title -->
        <div class="row justify-center q-mb-sm">
          <q-input
            dense
            autogrow
            class="q-px-md col q-mt-sm"
            label="Title"
            color="primary"
            v-model="formInfo.title"
          ></q-input>
        </div>

        <!-- Description -->
        <div class="row justify-center q-mb-sm">
          <q-input
            dense
            autogrow
            class="q-px-md col q-mt-sm"
            label="Title"
            color="primary"
            v-model="formInfo.description"
          ></q-input>
        </div>

        <!-- Inactive -->
        <div class="row justify-center q-pl-sm">
          <div class="col-8 label" style="display: flex; align-items: center">
            Inactive
          </div>
          <div class="col-4" style="display: flex; align-items: center">
            <q-toggle
              class="q-mb-none q-px-none"
              style="max-width: 75px"
              v-model="formInfo.inactive"
              color="primary"
              keep-color
            />
          </div>
        </div>

        <!-- Include Photos -->
        <div class="row justify-center q-pl-sm">
          <div class="col-8 label" style="display: flex; align-items: center">
            Include Photos
          </div>
          <div class="col-4" style="display: flex; align-items: center">
            <q-toggle
              class="q-mb-none q-px-none"
              style="max-width: 75px"
              v-model="formInfo.includePhotos"
              color="primary"
              keep-color
            />
          </div>
        </div>

        <!-- Include Videos -->
        <div class="row justify-center q-pl-sm">
          <div class="col-8 label" style="display: flex; align-items: center">
            Include Videos
          </div>
          <div class="col-4" style="display: flex; align-items: center">
            <q-toggle
              class="q-mb-none q-px-none"
              style="max-width: 75px"
              v-model="formInfo.includeVideos"
              color="primary"
              keep-color
            />
          </div>
        </div>

        <!-- Include Notes -->
        <div class="row justify-center q-pl-sm">
          <div class="col-8 label" style="display: flex; align-items: center">
            Include Notes
          </div>
          <div class="col-4" style="display: flex; align-items: center">
            <q-toggle
              class="q-mb-none q-px-none"
              style="max-width: 75px"
              v-model="formInfo.includeNotes"
              color="primary"
              keep-color
            />
          </div>
        </div>

        <!-- Include Signatures -->
        <div class="row justify-center q-pl-sm">
          <div class="col-8 label" style="display: flex; align-items: center">
            Include Signatures
          </div>
          <div class="col-4" style="display: flex; align-items: center">
            <q-toggle
              class="q-mb-none q-px-none"
              style="max-width: 75px"
              v-model="formInfo.includeSignatures"
              color="primary"
              keep-color
            />
          </div>
        </div>
      </q-card-section>
    </q-card>
  </div>
</template>

<script setup>
import { ref } from "vue";
import ComponentsListItem from "../../components/ComponentsPanel/ComponentsListItem.vue";

const props = defineProps({ components: Object, formInfo: Object });
const emit = defineEmits(["dragStart", "dragEnd"]);
const dragValid = ref(false);

function onDragStart(index) {
  emit("dragStart", index);
}
</script>

<style scoped></style>
