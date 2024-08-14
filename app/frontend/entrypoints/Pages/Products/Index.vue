<template>
  <Layout>
    <div class="q-pa-md q-mt-lg">
      <q-table
        title="Products"
        :rows="rows"
        :columns="columns"
        row-key="name"
        separator="horizontal"
      >
        <template v-slot:top>
          <div class="row justify-between">
            <div class="text-h4">Products</div>

            <Link href="/products/new">
              <q-icon name="add" size="sm" />
            </Link>
          </div>
        </template>
        <template v-slot:body-cell-description="props">
          <q-td :props="props">
            <div
              style="
                max-width: 250px;
                text-overflow: ellipsis;
                white-space: nowrap;
                overflow: hidden;
              "
            >
              {{ props.row.description }}
            </div>
          </q-td>
        </template>
        <template v-slot:body-cell-image="props">
          <q-td :props="props">
            <img
              :src="props.row.image"
              alt="Product Image"
              style="width: 100px; height: auto"
            />
          </q-td>
        </template>
        <template v-slot:body-cell-actions="props">
          <q-td :props="props">
            <div>
              <Link
                :href="getProductEdit(props.row.id)"
                as="button"
                type="button"
                class="q-mr-sm"
              >
                <q-icon size="sm" name="edit" />
              </Link>

              <Link
                :href="getProductHref(props.row.id)"
                method="delete"
                as="button"
                type="button"
              >
                <q-icon size="sm" name="delete" />
              </Link>
            </div>
          </q-td>
        </template>
      </q-table>
    </div>
  </Layout>
</template>

<script setup>
import Layout from "../../layouts/SiteLayout.vue";
import { Link } from "@inertiajs/vue3";
import { ref, onMounted, toRaw } from "vue";

const props = defineProps({ products: Object });

onMounted(() => {
  console.log(props.products);
});

const columns = ref([
  {
    name: "name",
    label: "Name",
    align: "left",
    field: (row) => row.name,
  },
  {
    name: "description",
    align: "left",
    label: "Description",
    field: "description",
  },
  {
    name: "price",
    align: "center",
    label: "Price",
    field: "price",
  },
  {
    name: "image",
    align: "center",
    label: "Photo",
    field: "image",
  },
  {
    name: "actions",
    align: "center",
    label: "Actions",
    field: "actions",
  },
]);

const rows = ref(props.products);
// const rows = ref([
//   { name: "Shoe", description: "Shoe", price: 89.99, image: null },
//   { name: "Hand Bag", description: "Hand Bag", price: 19.99, image: null },
// ]);
const getProductHref = (id) => {
  return `/products/${id}`;
};
const getProductEdit = (id) => {
  return `/products/${id}/edit`;
};
</script>
