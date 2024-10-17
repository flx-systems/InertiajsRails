<template>
  <q-card flat bordered class="q-mr-lg q-mt-none q-px-none">
    <!-- Title -->
    <q-card-section class="q-pb-none">
      <div class="text-bold text-center">Inspector</div>
    </q-card-section>

    <hr class="q-mb-sm" />

    <!-- Edit -->
    <q-card-section
      class="q-mx-none q-pt-none"
      style="max-height: 80vh; overflow-y: scroll; overflow-x: hidden"
    >
      <div class="col q-mx-none q-px-none">
        <!-- Properties Section -->
        <inspector-section-header :top="true"
          >Properties</inspector-section-header
        >

        <!-- Text for text block -->
        <div
          class="row justify-center q-mb-sm"
          v-if="field?.text !== undefined"
        >
          <q-input
            dense
            autogrow
            class="q-px-md col q-mt-sm"
            label="Text"
            color="primary"
            v-model="text"
          ></q-input>
        </div>

        <!-- Image source for images -->
        <div
          class="row justify-center q-mb-sm"
          v-if="field?.imageSource !== undefined"
        >
          <q-input
            dense
            autogrow
            class="q-px-md col q-mt-sm"
            label="Image Source"
            color="primary"
            v-model="imageSource"
          ></q-input>
        </div>

        <!-- Label -->
        <div
          class="row justify-center q-mb-sm"
          v-if="field?.label !== undefined"
        >
          <q-input
            dense
            autogrow
            class="q-px-md col q-mt-sm"
            label="Label"
            color="primary"
            v-model="label"
          ></q-input>
        </div>

        <!-- Placeholder -->
        <div
          class="row justify-center q-mb-sm"
          v-if="field?.placeholder !== undefined"
        >
          <q-input
            dense
            autogrow
            class="q-px-md col-12 q-mt-sm"
            label="Placeholder"
            v-model="placeholder"
          ></q-input>
        </div>

        <!-- Required -->
        <div
          class="row justify-center q-pl-sm"
          v-if="field?.required !== undefined"
        >
          <div class="col-8 label" style="display: flex; align-items: center">
            Required
          </div>
          <div class="col-4" style="display: flex; align-items: center">
            <q-toggle
              class="q-mb-none q-px-none"
              style="max-width: 75px"
              v-model="required"
              color="primary"
              keep-color
            />
          </div>
        </div>

        <!-- Include Photo -->
        <div
          class="row justify-center q-pl-sm"
          v-if="field?.includePhoto !== undefined"
        >
          <div class="col-8 label" style="display: flex; align-items: center">
            Include Photo
          </div>
          <div class="col-4" style="display: flex; align-items: center">
            <q-toggle
              class="q-mb-none q-px-none"
              style="max-width: 75px"
              v-model="includePhoto"
              color="primary"
              keep-color
            />
          </div>
        </div>

        <!-- Multiple Fields -->
        <div
          class="row justify-center q-pl-sm"
          v-if="field?.multipleRows !== undefined"
        >
          <div class="col-8 label" style="display: flex; align-items: center">
            Multiple Rows
          </div>
          <div class="col-4" style="display: flex; align-items: center">
            <q-toggle
              class="q-mb-none q-px-none"
              style="max-width: 75px"
              v-model="multipleRows"
              color="primary"
              keep-color
            />
          </div>
        </div>

        <!-- Type Section -->
        <template v-if="props.field?.label !== undefined">
          <inspector-section-header>Field Type</inspector-section-header>
          <div class="row justify-center q-mb-sm">
            <q-select
              dense
              class="q-px-md col-12 q-mt-sm"
              v-model="componentSelected"
              :options="componentOptions"
              label="Field Type"
            ></q-select>
          </div>
        </template>

        <!-- Label Options Input -->
        <template v-if="props.field?.inputType === 'select'">
          <div class="row justify-center q-mb-sm">
            <q-input
              autogrow
              dense
              class="q-px-md"
              label="Add Options"
              v-model="selectOptionsInput"
              placeholder="Press ENTER to add"
              @keyup.enter="addSelectOption"
            ></q-input>
          </div>

          <!-- Label Options -->
          <q-list v-show="props.field?.inputType === 'select'">
            <transition-group name="list" tag="div">
              <q-chip
                v-for="(option, index) in selectOptions"
                :key="index"
                removable
                color="blue-grey-1"
                style="border: 1px solid #e0eaee"
                :ripple="false"
                class="full-width q-pl-md"
                @remove="deleteLabelOption(index)"
                >{{ option }}</q-chip
              >
            </transition-group>
          </q-list>
        </template>

        <!-- Field Validation -->
        <template v-if="props.field?.validationRules !== undefined">
          <inspector-section-header>
            Validation
            <template #moreInfo>
              Set rules for the range of numbers allowed to be entered.
            </template>
          </inspector-section-header>

          <div class="row justify-center q-mb-sm">
            <!-- Rules -->
            <div class="row" v-for="(rule, index) in validationRules">
              <!-- Evaluator Select -->
              <div class="col" style="max-width: 75px">
                <q-select
                  dense
                  :options="evaluatorList"
                  v-model="rule.evaluator"
                  @change="changeValidationRule"
                ></q-select>
              </div>

              <!-- Value Input -->
              <div class="col q-pl-sm q-pr-none">
                <q-input
                  type="number"
                  dense
                  v-model="rule.compareTo"
                  label="Value"
                  @change="changeValidationRule"
                ></q-input>
              </div>

              <!-- Remove Rule -->
              <div class="col flex flex-center" style="max-width: 12px">
                <q-btn
                  dense
                  flat
                  size="sm"
                  color="grey"
                  icon="close"
                  @click.prevent="removeValidationRule(index)"
                ></q-btn>
              </div>
            </div>

            <!-- Add new validation -->
            <q-btn
              flat
              dense
              color="primary"
              v-text="'Add Rule'"
              class="q-px-sm q-mt-sm"
              style="width: 50%; font-size: 12px"
              @click.prevent="addValidationRule"
            ></q-btn>
          </div>
        </template>

        <!-- Condition Section -->
        <template v-if="props.field?.conditions !== undefined">
          <inspector-section-header>
            Conditions
            <template #moreInfo>
              Set conditions for this field. If any condition isn't met, this
              field won't display.
            </template>
          </inspector-section-header>

          <!-- Condition List -->
          <div class="row justify-center q-mx-none">
            <q-card
              v-for="(condition, index) in conditions"
              :key="index"
              class="q-ma-sm condition-card relative-position"
              flat
            >
              <!-- Condition Fields -->
              <q-card-section>
                <!-- Target Field -->
                <q-select
                  class="row q-mb-sm"
                  dense
                  :options="conditionSelectOptions"
                  label="Field"
                  v-model="condition.id"
                  @update:modelValue="changeConditions"
                >
                  <!-- Value shows label -->
                  <template
                    v-slot:selected="scope"
                    v-if="condition.id !== undefined"
                  >
                    <q-item>
                      <q-item-section>
                        <q-item-label>
                          {{ conditionLabels[index] }}
                        </q-item-label>
                      </q-item-section>
                    </q-item>
                  </template>

                  <!-- Drop down shows label -->
                  <template v-slot:option="scope">
                    <q-item
                      v-bind="scope.itemProps"
                      :disable="
                        conditionOptions[scope.index]?.referenceId ===
                        field?.referenceId
                      "
                    >
                      <q-item-section>
                        <q-item-label>
                          {{ conditionOptions[scope.index]?.description }}
                        </q-item-label>
                      </q-item-section>
                    </q-item>
                  </template>
                </q-select>

                <!-- Evaluator -->
                <q-select
                  class="row q-mb-sm"
                  dense
                  label="Evaluator"
                  :options="
                    objectifiedConditionOptions[condition.id]
                      ?.conditionEvaluators
                  "
                  v-model="condition.evaluator"
                  @change="changeConditions"
                ></q-select>

                <!-- Value -->
                <!-- Checkbox type -->
                <template
                  v-if="
                    objectifiedConditionOptions[condition.id]?.type ===
                    'checkbox'
                  "
                >
                  <div class="row justify-center q-pl-sm">
                    <div
                      class="col-8 label"
                      style="display: flex; align-items: center"
                    >
                      Value
                    </div>
                    <div
                      class="col-4"
                      style="display: flex; align-items: center"
                    >
                      <q-checkbox
                        class="q-mb-none q-px-none"
                        style="max-width: 75px"
                        v-model="condition.compareTo"
                        color="primary"
                        @change="changeConditions"
                      />
                    </div>
                  </div>
                </template>

                <!-- Select type -->
                <template
                  v-else-if="
                    objectifiedConditionOptions[condition.id]?.type === 'select'
                  "
                >
                  <q-select
                    dense
                    :label="
                      objectifiedConditionOptions[condition.id]?.selectOptions
                        ?.length > 0
                        ? 'Value'
                        : 'No options provided'
                    "
                    :options="
                      objectifiedConditionOptions[condition.id].selectOptions
                    "
                    v-model="condition.compareTo"
                  ></q-select>
                </template>

                <!-- Input field -->
                <q-input
                  v-else
                  dense
                  :type="
                    objectifiedConditionOptions[condition.id]?.type || 'text'
                  "
                  v-model="condition.compareTo"
                  label="Value"
                  @change="changeConditions"
                ></q-input>

                <!-- Remove Rule -->
                <q-btn
                  dense
                  flat
                  class="absolute-top-right"
                  size="sm"
                  color="grey"
                  icon="close"
                  @click.prevent="removeCondition(index)"
                ></q-btn>
              </q-card-section>
            </q-card>

            <!-- Add new condition -->
            <q-btn
              flat
              dense
              color="primary"
              v-text="'Add Condition'"
              class="q-px-sm q-mt-sm"
              style="width: 50%; font-size: 12px"
              @click.prevent="addCondition"
            ></q-btn>
          </div>
        </template>

        <!-- Style Section -->
        <inspector-section-header>Style</inspector-section-header>
        <div class="row justify-center q-mb-sm">
          <!-- Width Select -->
          <div class="row q-my-sm">
            <div class="col flex items-center label">Width</div>
            <div class="col">
              <q-btn-group unelevated>
                <q-btn
                  unelevated
                  class="button-background"
                  :color="props.field?.width === 6 ? 'primary' : ''"
                  :text-color="
                    props.field?.width === 6 ? 'black' : 'blue-grey-4'
                  "
                  label="half"
                  dense
                  @click.prevent="changeWidth(6)"
                />
                <q-btn
                  unelevated
                  class="button-background"
                  :color="props.field?.width === 12 ? 'primary' : ''"
                  :text-color="
                    props.field?.width === 12 ? 'black' : 'blue-grey-4'
                  "
                  label="full"
                  dense
                  @click.prevent="changeWidth(12)"
                />
              </q-btn-group>
            </div>
          </div>

          <!-- Height Select -->
          <div class="row q-my-sm" v-if="props.field?.height !== undefined">
            <div class="col flex items-center label">Height</div>
            <div class="col">
              <q-btn-group unelevated>
                <q-btn
                  unelevated
                  class="button-background-sm"
                  :color="props.field?.height === 100 ? 'primary' : ''"
                  :text-color="
                    props.field?.height === 100 ? 'black' : 'blue-grey-4'
                  "
                  label="SM"
                  dense
                  @click.prevent="changeHeight(100)"
                />
                <q-btn
                  unelevated
                  class="button-background-sm"
                  :color="props.field?.height === 250 ? 'primary' : ''"
                  :text-color="
                    props.field?.height === 250 ? 'black' : 'blue-grey-4'
                  "
                  label="MD"
                  dense
                  @click.prevent="changeHeight(250)"
                />
                <q-btn
                  unelevated
                  class="button-background-sm"
                  :color="props.field?.height === 400 ? 'primary' : ''"
                  :text-color="
                    props.field?.height === 400 ? 'black' : 'blue-grey-4'
                  "
                  label="LG"
                  dense
                  @click.prevent="changeHeight(400)"
                />
              </q-btn-group>
            </div>
          </div>

          <!-- Header -->
          <div
            class="row justify-center q-pl-sm"
            v-if="field?.header !== undefined"
          >
            <div class="col-8 label" style="display: flex; align-items: center">
              Header
            </div>
            <div class="col-4" style="display: flex; align-items: center">
              <q-toggle
                class="q-mb-none q-px-none"
                style="max-width: 75px"
                v-model="header"
                color="primary"
                keep-color
              />
            </div>
          </div>
        </div>
      </div>
    </q-card-section>
  </q-card>
</template>

<script setup>
import { computed, ref, toRaw, watch } from "vue";
import InspectorSectionHeader from "@/entrypoints/components/InspectorPanel/InspectorSectionHeader.vue";

const emit = defineEmits(["field-change", "type-change"]);
const props = defineProps({
  components: Array,
  field: Object,
  fields: Array,
  index: Number,
  conditionOptions: Array,
  updateKey: Number,
});

const label = ref("");
const text = ref("");
const imageSource = ref("");
const placeholder = ref("");
const required = ref(false);
const includePhoto = ref(false);
const multipleRows = ref(false);
const header = ref(false);
const selectOptionsInput = ref("");
const selectOptions = ref([]);
const componentSelected = ref(0);
const validationRules = ref([]);
const conditions = ref([]);
const evaluatorList = ["<", "<=", "=", ">=", ">"];

// This is a version of condition options where keys are the reference ids. We need condition options to be ordered
// as they are on the page but this prevents us from getting specific info for a given reference id. This let's us
// pull information like the field type using a reference id rather than index position
const objectifiedConditionOptions = computed(() => {
  const obj = {};
  props.conditionOptions.forEach((c) => {
    obj[c.referenceId] = c;
  });
  return obj;
});

// This is used to display the selected label for each condition. This has to be recalculated on condition
// select and any time another field is targeted to update in case the field it was targeting had a label change
const conditionLabels = ref([]);

// Formatted list of components for dropdown filtering out visual only elements
let componentOptions = computed(() => {
  return props.components
    .filter((item) => item.label !== undefined)
    .map((item) => item.type);
});

// This is used to convert the object array into an int array for the select
const conditionSelectOptions = computed(() => {
  return props.conditionOptions.map((item) => {
    return item.referenceId;
  });
});

// Update target field
watch(
  () => props.updateKey,
  () => {
    // Don't update if it was just closed
    if (!props.field) return;

    // Update input field values
    label.value = props.field?.label || "";
    placeholder.value = props.field?.placeholder;
    required.value = props.field?.required;
    multipleRows.value = props.field?.multipleRows;
    componentSelected.value = props.field?.type;
    selectOptions.value = props.field?.selectOptions;
    text.value = props.field?.text;
    imageSource.value = props.field?.imageSource;
    header.value = props.field?.header;

    validationRules.value =
      props.field?.validationRules === null ? [] : props.field?.validationRules;
    conditions.value =
      props.field?.conditions === null ? [] : props.field?.conditions;

    updateConditionalLabels();
  },
);

// Label change
watch(
  () => label.value,
  () => {
    emit("field-change", props.index, "label", label.value);
  },
);

// Text change
watch(
  () => text.value,
  () => {
    emit("field-change", props.index, "text", text.value);
  },
);

// Image source
watch(
  () => imageSource.value,
  () => {
    emit("field-change", props.index, "imageSource", imageSource.value);
  },
);

// Placeholder change
watch(
  () => placeholder.value,
  () => {
    emit("field-change", props.index, "placeholder", placeholder.value);
  },
);

// Required change
watch(
  () => required.value,
  () => {
    emit("field-change", props.index, "required", required.value);
  },
);

// Include photo change
watch(
  () => includePhoto.value,
  () => {
    emit("field-change", props.index, "includePhoto", includePhoto.value);
  },
);

// Multiple rows change
watch(
  () => multipleRows.value,
  () => {
    emit("field-change", props.index, "multipleRows", multipleRows.value);
  },
);

// Header change
watch(
  () => header.value,
  () => {
    emit("field-change", props.index, "header", header.value);
  },
);

// Label options change
watch(
  () => selectOptions.value,
  () => {
    emit("field-change", props.index, "selectOptions", selectOptions.value);
  },
);

// Type change
watch(
  () => componentSelected.value,
  () => {
    emit("type-change", props.index, componentSelected.value);
  },
);

function changeWidth(width) {
  emit("field-change", props.index, "width", width);
}

function changeHeight(height) {
  emit("field-change", props.index, "height", height);
}

function addSelectOption() {
  // Return early if nothing typed
  if (selectOptionsInput.value === "") return;

  // Take text from field and clear field
  const text = selectOptionsInput.value;
  selectOptionsInput.value = "";

  // Split on the comma and add each to label options
  const options = text.split(",").map((item) => item.trim());
  selectOptions.value = selectOptions.value.concat(options);
}

function deleteLabelOption(index) {
  // Remove label from list
  selectOptions.value.splice(index, 1);
}

function addValidationRule() {
  validationRules.value.push({ evaluator: "=", compareTo: "0" });

  // Manually update state of validations
  changeValidationRule();
}

function removeValidationRule(index) {
  validationRules.value.splice(index, 1);

  // Manually update state of validations
  changeValidationRule();
}

function changeValidationRule() {
  emit("field-change", props.index, "validationRules", validationRules.value);
}

function addCondition() {
  conditions.value.push({ id: null, evaluator: "=", compareTo: null });

  // Manually update state of validations
  changeConditions();
}

function removeCondition(index) {
  conditions.value.splice(index, 1);

  // Manually update state of validations
  changeConditions();
}

function changeConditions() {
  updateConditionalLabels();
  emit("field-change", props.index, "conditions", conditions.value);
}

function updateConditionalLabels() {
  // Empty out labels
  conditionLabels.value = [];

  // Re-fetch the labels for each field
  conditions.value.forEach((c) => {
    // Find the field this condition is referencing
    const field = props.fields.find((f) => f.referenceId === c.id);

    // Return if the field is undefined
    if (field === undefined) return;

    // Otherwise, add it to the array
    conditionLabels.value.push(field.label);
  });
}
</script>

<style lang="scss">
@import "../../quasar-variables.sass";

/* Obnoxious select boxes are tiny for some unknown reason */
div.q-field__control-container.col.relative-position.row.no-wrap.q-anchor--skip {
  min-width: 100% !important;
}

.label {
  font-size: 12px;
  font-weight: bold;
  color: $light-text;
}

.condition-card {
  background-color: $background !important;
}

.section-header {
  background-color: $light-background;
  height: 40px;
  border-radius: 8px;
  color: $light-text;
  font-weight: bold;
  font-size: 12px;
}

.button-background {
  background-color: $background !important;
  max-height: 30px;
  min-width: 60px;
}

.button-background-sm {
  background-color: $background !important;
  max-height: 30px;
  min-width: 40px;
}

/* Initial state (during the enter and leave phases) */
.list-enter,
.list-leave-to {
  opacity: 0;
  transform: translateX(-30px);
}

/* Active state (what the element is doing throughout the enter and leave phases) */
.list-enter-active,
.list-leave-active {
  transition: all 0.33s;
}

/* End state (the state of the element when it has finished entering) */
.list-enter-to {
  opacity: 1;
  transform: translateX(0);
}
</style>
