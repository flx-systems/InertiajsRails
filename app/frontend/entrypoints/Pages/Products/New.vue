<template>
  <Layout>
    <div class="q-pa-md q-mt-lg">
      <div class="text-h2">Add Product</div>

      <div class="q-pa-md" style="max-width: 400px">
        <q-form @submit="onSubmit" @reset="onReset" class="q-gutter-md">
          <q-input
            filled
            v-model="formData.product.name"
            label="Product Name *"
            lazy-rules
            :rules="[
              (val) => (val && val.length > 0) || 'Please type something',
            ]"
          />

          <q-input
            filled
            type="textarea"
            v-model="formData.product.description"
            label="Description *"
            lazy-rules
            :rules="[
              (val) => (val && val.length > 0) || 'Please type something',
            ]"
          />

          <q-input
            filled
            type="number"
            v-model="formData.product.price"
            label="Price *"
            lazy-rules
            :rules="[
              (val) => (val && val.length > 0) || 'Please type something',
            ]"
          />

          <q-file
            filled
            v-model="formData.product.image"
            @input="formData.product.image = $event.target.files[0]"
            label="Photo *"
          />
          <div>
            <q-btn label="Submit" type="submit" color="primary" />
            <q-btn
              label="Reset"
              type="reset"
              color="primary"
              flat
              class="q-ml-sm"
            />
          </div>
        </q-form>
      </div>
    </div>
  </Layout>
</template>

<script setup>
import Layout from "../../layouts/SiteLayout.vue";
import { useForm } from "@inertiajs/vue3";

const formData = useForm({
  product: {
    name: "",
    description: "",
    price: 0.0,
    image: null,
  },
});

const onSubmit = function () {
  console.log("Form submission");
  formData.post("/products");
};

// to reset validations:
const onReset = function () {
  console.log("TODO");
};
</script>
