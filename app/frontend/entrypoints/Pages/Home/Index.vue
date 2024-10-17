<template>
  <div class="background-color full-height">
    <div class="row q-col-gutter-sm q-my-none">
      <!-- Component List -->
      <div class="col" style="max-width: 275px; min-width: 275px">
        <components-panel
          style="position: sticky; top: 32px"
          :form-info="formInfo"
          :components="components"
          @drag-start="onComponentDrag"
          @drag-end="onComponentDragEnd"
        ></components-panel>
      </div>

      <!-- Preview -->
      <div class="col">
        <preview-form
          style="margin-top: 24px"
          :fields="fields"
          :child-fields="childFields"
          :form-title="formInfo.title"
          :target-field-index="targetFieldIndex"
          :show-drop-off="draggingComponent !== -1"
          @target="targetField"
          @drag-drop="onComponentDrop"
          @delete-field="deleteField"
          @move-field-to-position="moveFieldToPosition"
        ></preview-form>
      </div>

      <!-- Inspector -->
      <transition name="slide">
        <div
          class="col"
          style="max-width: 350px; min-width: 300px"
          v-show="targetFieldIndex !== null"
        >
          <inspector-panel
            class="col"
            style="position: sticky; top: 32px"
            :update-key="inspectorKey"
            :components="components"
            :field="fields[targetFieldIndex]"
            :fields="fields"
            :condition-options="conditionOptions"
            :index="targetFieldIndex"
            @field-change="fieldChange"
            @type-change="changeFieldType"
          ></inspector-panel>
        </div>
      </transition>
    </div>
  </div>
</template>

<script setup>
import ComponentsPanel from "../../components/ComponentsPanel/ComponentsPanel.vue";
import PreviewForm from "../../components/PreviewPanel/PreviewPanel.vue";
import InspectorPanel from "../../components/InspectorPanel/InspectorPanel.vue";
import { computed, onMounted, ref, watch } from "vue";

//----- PROPERTIES -----//

const formInfo = ref({
  title: "AMC Form",
  description: "Description here",
  inactive: false,
  includePhotos: false,
  includeVideos: false,
  includeNotes: false,
  includeSignatures: false,
});

// Components Panel
const draggingComponent = ref(-1);
const components = [
  {
    type: "Text Field",
    inputType: "text_field",
    icon: "text_fields",
    label: "Empty Label",
    placeholder: "Enter text",
    required: true,
    multipleRows: false,
    width: 12,
    includePhoto: false,
    conditions: null,
    conditionType: "text",
    conditionEvaluators: ["="],
  },
  {
    type: "Number Field",
    inputType: "text_field",
    icon: "pin",
    label: "Empty Label",
    placeholder: "Enter number",
    required: true,
    multipleRows: false,
    width: 12,
    includePhoto: false,
    validationRules: null,
    conditions: null,
    conditionType: "number",
    conditionEvaluators: ["<", "<=", "=", ">=", ">"],
  },
  {
    type: "Select Box",
    inputType: "select",
    icon: "list",
    label: "Empty Label",
    placeholder: "Select option",
    selectOptions: [],
    required: true,
    multipleRows: false,
    width: 12,
    includePhoto: false,
    conditions: null,
    conditionType: "select",
    conditionEvaluators: ["="],
  },
  {
    type: "Yes/No",
    inputType: "checkbox",
    icon: "check_box",
    label: "Empty Label",
    required: true,
    width: 12,
    includePhoto: false,
    conditions: null,
    conditionType: "checkbox",
    conditionEvaluators: ["="],
  },
  {
    type: "Date and Time",
    inputType: "text_field",
    icon: "edit_calendar",
    label: "Empty Label",
    placeholder: "Enter datetime",
    required: true,
    multipleRows: false,
    width: 12,
    includePhoto: false,
    conditions: null,
    conditionType: "datetime-local",
    conditionEvaluators: ["<", "<=", "=", ">=", ">"],
  },
  {
    type: "Date",
    inputType: "text_field",
    icon: "calendar_month",
    label: "Empty Label",
    placeholder: "Enter date",
    required: true,
    multipleRows: false,
    width: 12,
    includePhoto: false,
    conditions: null,
    conditionType: "date",
    conditionEvaluators: ["<", "<=", "=", ">=", ">"],
  },
  {
    type: "Time",
    inputType: "text_field",
    icon: "schedule",
    label: "Empty Label",
    placeholder: "Enter time",
    required: true,
    multipleRows: false,
    width: 12,
    includePhoto: false,
    conditions: null,
    conditionType: "time",
    conditionEvaluators: ["<", "<=", "=", ">=", ">"],
  },
  {
    type: "Text Block",
    inputType: "text_block",
    icon: "text_snippet",
    width: 12,
    text: "",
    header: false,
    conditions: null,
  },
  {
    type: "Image",
    inputType: "image",
    icon: "image",
    width: 12,
    height: 250,
    imageSource: "",
    conditions: null,
  },
];

// Preview Panel
const fields = ref([]);
const targetFieldIndex = ref(null);
const childFields = ref([]);

// Inspector Panel
const inspectorKey = ref(0);
const conditionOptions = computed(() => {
  return fields.value
    .filter((f) => f.label !== undefined)
    .map((f, index) => ({
      description: f.label,
      type: f.conditionType,
      referenceId: f.referenceId,
      value: index,
      selectOptions: f.selectOptions,
      conditionEvaluators: f.conditionEvaluators,
    }));
});

// This is used to give unique ids to all fields
const referenceCounter = ref(0);

//----- METHODS -----//

// Keyboard shortcuts
document.addEventListener("keydown", function (e) {
  // Add new field to end of list. Defaults to Text Field
  if (e.key === "Enter" && e.shiftKey) {
    draggingComponent.value = 0;
    const index = fields.value.length;
    onComponentDrop(index);
  }

  // Scroll between fields with arrow keys if fields exist
  if (fields.value.length > 0) {
    switch (e.key) {
      case "ArrowDown":
        targetFieldIndex.value++;
        if (targetFieldIndex.value >= fields.value.length)
          targetFieldIndex.value--;
        inspectorKey.value++;
        break;

      case "ArrowUp":
        targetFieldIndex.value--;
        if (targetFieldIndex.value < 0) targetFieldIndex.value = 0;
        inspectorKey.value++;
        break;
    }
  }
});

// Watch for changes on target field index to update child fields selected
watch(
  () => inspectorKey.value,
  () => {
    // Update child fields
    if (targetFieldIndex.value !== null) {
      collectChildFields(fields.value[targetFieldIndex.value].referenceId);
    } else {
      // If nothing selected, clear child fields
      childFields.value = [];
    }
  },
);

// Updates what field is currently selected
function targetField(index) {
  targetFieldIndex.value = targetFieldIndex.value === index ? null : index;
  inspectorKey.value++;
}

// Called when a component is being drug
function onComponentDrag(index) {
  draggingComponent.value = index;
}

// Called when a component is dropped anywhere
function onComponentDragEnd() {
  draggingComponent.value = -1;
}

// Adds a field at a specific index in the fields array
function onComponentDrop(position) {
  // If rearranging and not adding a new component, don't do anything
  if (draggingComponent.value === -1) return;

  const fieldInfo = { ...components[draggingComponent.value] };
  fieldInfo["referenceId"] = referenceCounter.value;
  fields.value.splice(position, 0, fieldInfo);

  draggingComponent.value = -1;
  referenceCounter.value++;
  inspectorKey.value++;
}

// Deletes a field from the field list
function deleteField(index) {
  deleteRelatedConditions(fields.value[index].referenceId);
  fields.value.splice(index, 1);

  // Safety range for target field
  if (targetFieldIndex.value >= fields.value.length)
    targetFieldIndex.value = fields.value.length - 1;

  inspectorKey.value++;

  // Close inspector if last field deleted
  if (fields.value.length <= 0) targetFieldIndex.value = null;
}

// Deletes all conditions related to a field index
function deleteRelatedConditions(referenceId) {
  // Iterate over each condition in each field
  fields.value.forEach((f, fieldIndex) => {
    // Skip if no conditions
    if (f.conditions === null) return;

    // Iterate over each condition
    f.conditions.forEach((c, conditionIndex) => {
      // If the condition id matches this index, delete the condition
      if (c.id === referenceId) {
        fields.value[fieldIndex].conditions.splice(conditionIndex, 1);
      }
    });
  });
}

// Resets value for all conditions related to this field index
function resetRelatedConditions(referenceId) {
  // Iterate over each condition in each field
  fields.value.forEach((f, fieldIndex) => {
    // Skip if no conditions
    if (f.conditions === null) return;

    // Iterate over each condition
    f.conditions.forEach((c, conditionIndex) => {
      // If the condition id matches this index, delete the condition
      if (c.id === referenceId) {
        fields.value[fieldIndex].conditions[conditionIndex].compareTo = null;
        fields.value[fieldIndex].conditions[conditionIndex].evaluator = "=";
      }
    });
  });
}

// Collects all fields that have this as a conditional parent and stores it in array
function collectChildFields(referenceId) {
  // Reset child fields
  childFields.value = [];

  // Iterate over each condition in each field
  fields.value.forEach((f, fieldIndex) => {
    // Skip if no conditions
    if (f.conditions === null) return;

    // Iterate over each condition
    f.conditions.forEach((c, conditionIndex) => {
      // If the condition id matches this index, delete the condition
      if (c.id === referenceId) childFields.value.push(f.referenceId);
    });
  });
}

// Changes the type of a field. This will reload the object with a copy of the new component data
function changeFieldType(index, type) {
  // Don't change to already selected type
  if (fields.value[index].type === type) return;

  // Get copy of new component type
  const component = {
    ...components.find((component) => component.type === type),
  };

  // Save translatable data to new copy
  if (component.label !== undefined && fields.value[index].label !== undefined)
    component.label = fields.value[index].label;

  // Include photo
  if (component.includePhoto)
    component.includePhoto = fields.value[index].includePhoto;
  component.width = fields.value[index].width;

  // Multiple rows
  if (
    component.multipleRows !== undefined &&
    fields.value[index].multipleRows
  ) {
    component.multipleRows = fields.value[index].multipleRows;
  }

  // Select options
  if (
    component.selectOptions !== undefined &&
    fields.value[index].selectOptions
  ) {
    component.selectOptions = fields.value[index].selectOptions;
  }

  // Conditions
  component.conditions = fields.value[index].conditions;

  // Transfer reference id
  component["referenceId"] = fields.value[index].referenceId;

  // Reset condition values related to this reference index
  resetRelatedConditions(fields.value[index].referenceId);

  // Replace field
  fields.value[index] = component;
  inspectorKey.value++;
}

// Changes a property from the inspector panel to the field object
function fieldChange(index, property, value) {
  // If this property doesn't exist in the field, don't add it
  if (fields.value[index][property] === undefined) return;

  fields.value[index][property] = value;
}

// Switches the position of a field from one index to another
function moveFieldToPosition(from, to) {
  // Store copy of object
  const el = fields.value[from];

  // Delete from array
  fields.value.splice(from, 1);

  // Put it in the new spot, select the index if it was previously selected, and refresh inspector
  fields.value.splice(to, 0, el);
  if (targetFieldIndex.value === from) targetFieldIndex.value = to;
  inspectorKey.value++;
}
</script>

<style scoped lang="scss">
@import "../../quasar-variables.sass";

.background-color {
  background-color: $background;
}

.primary-background {
  background-color: $primary;
  color: white;
}

.primary-text {
  color: $primary;
}

.primary-border {
  border-color: $primary;
}

.slide-enter-active,
.slide-leave-active {
  transition: all 0.3s ease;
}
.slide-enter-from,
.slide-leave-to {
  transform: translateX(100%);
  opacity: 0;
}
.slide-enter-to,
.slide-leave-from {
  transform: translateX(0);
  opacity: 1;
}
</style>
