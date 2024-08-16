<template>
  <Layout>
    <div class="q-pa-md q-mt-lg">
      <q-table
        title="Products"
        :rows="filteredData"
        :columns="columns"
        row-key="name"
        separator="horizontal"
      >
        <template v-slot:top>
          <div class="row justify-between">
            <div class="col text-h4">Products</div>
            <Link class="col text-right" href="/products/new">
              <q-icon name="add" size="sm" />
            </Link>
          </div>
          <div class="row justify-center q-mt-lg">
            <q-input
              v-model="searchQuery"
              placeholder="Search..."
              outlined
              dense
              class="col q-mb-md"
            />
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
        <template v-slot:body-cell-price="props">
          <q-td :props="props">
            {{ formatter.format(props.row.price) }}
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
import { ref, onMounted, computed } from "vue";

const props = defineProps({ products: Object });

onMounted(() => {
  console.log(props.products);
});

const columns = ref([
  {
    name: "name",
    label: "Name",
    align: "left",
    sortable: true,
    field: "name",
  },
  {
    name: "description",
    align: "left",
    label: "Description",
    sortable: true,
    field: "description",
  },
  {
    name: "price",
    align: "center",
    label: "Price",
    sortable: true,
    field: "price",
  },
  {
    name: "image",
    align: "center",
    label: "Photo",
    sortable: true,
    field: "image",
  },
  {
    name: "actions",
    align: "center",
    label: "Actions",
    sortable: true,
    field: "actions",
  },
]);

const searchQuery = ref("");

const rows = ref(props.products);

// Filer rows
const filteredData = computed(() => {
  if (!searchQuery.value.trim()) return rows.value;
  return rows.value.filter((row) => {
    return Object.values(row).some((value) =>
      value.toString().toLowerCase().includes(searchQuery.value.toLowerCase()),
    );
  });
});

const getProductHref = (id) => {
  return `/products/${id}`;
};
const getProductEdit = (id) => {
  return `/products/${id}/edit`;
};
// Create our number formatter.
const formatter = new Intl.NumberFormat("en-US", {
  style: "currency",
  currency: "USD",

  // These options are needed to round to whole numbers if that's what you want.
  //minimumFractionDigits: 0, // (this suffices for whole numbers, but will print 2500.10 as $2,500.1)
  //maximumFractionDigits: 0, // (causes 2500.99 to be printed as $2,501)
});
</script>
