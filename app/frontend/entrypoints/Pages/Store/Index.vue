<template>
  <Layout>
    <div>
      <div class="row items-center">
        <div class="text-h3 q-pa-lg col">Shopping Cart</div>
        <div class="col-auto text-weight-bold">
          {{ formatter.format(cartStore.itemsTotal) }}
        </div>
      </div>

      <q-table
        title="Cart Details"
        :rows="rows"
        :columns="columns"
        row-key="name"
      >
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
        <template v-slot:body-cell-actions="props">
          <q-td :props="props">
            <q-icon
              @click="removeItem(props.row)"
              name="delete"
              color="red"
              size="sm"
            />
          </q-td>
        </template>
      </q-table>
    </div>
  </Layout>
</template>

<script setup>
import Layout from "../../layouts/SiteLayout.vue";
import { onMounted, computed } from "vue";
import { useCartStore } from "~/entrypoints/stores/index.js";
import { Link } from "@inertiajs/vue3";

const cartStore = useCartStore();
const rows = computed(() => cartStore.cartItems);
const columns = [
  {
    name: "name",
    label: "Name",
    field: "name",
    align: "left",
  },
  {
    name: "description",
    label: "Description",
    field: "description",
    align: "left",
  },
  {
    name: "price",
    label: "Price",
    field: "price",
    align: "center",
  },
  {
    name: "actions",
    label: "Actions",
    field: "actions",
    align: "center",
  },
];

function removeItem(item) {
  cartStore.removeItem(item);
}

// Create our number formatter.
const formatter = new Intl.NumberFormat("en-US", {
  style: "currency",
  currency: "USD",
  // These options are needed to round to whole numbers if that's what you want.
  //minimumFractionDigits: 0, // (this suffices for whole numbers, but will print 2500.10 as $2,500.1)
  //maximumFractionDigits: 0, // (causes 2500.99 to be printed as $2,501)
});

//const props = defineProps({ items: Object });
</script>
