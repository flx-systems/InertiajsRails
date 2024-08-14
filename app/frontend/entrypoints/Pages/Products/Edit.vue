<template>
  <Layout>
    <div class="q-pa-md q-mt-lg">
      <div class="text-h2">Edit Product</div>

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
            type="textarea"
            filled
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
import Layout from "~/entrypoints/layouts/SiteLayout.vue";
import { useForm } from "@inertiajs/vue3";

const props = defineProps({ product: Object });

const formData = useForm({
  product: {
    name: props.product.name,
    description: props.product.description,
    price: props.product.price,
    image: props.product.image,
  },
});

function onSubmit() {
  formData.patch(`/products/${props.product.id}`);
}

function onReset() {
  console.log("reset");
}
</script>
