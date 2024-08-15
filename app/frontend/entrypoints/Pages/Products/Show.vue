<template>
  <Layout>
    <div class="q-mt-sm">
      <Link href="/">
        <q-icon name="arrow_back" size="sm" color="black" />
      </Link>
    </div>
    <div class="q-mt-lg">
      <div class="row">
        <img
          class="col"
          :src="props.product.image"
          alt="image"
          style="max-width: 400px"
        />
        <div class="col">
          <div class="text-h2">{{ props.product.name }}</div>
          <div class="q-pt-md description text-body1">
            {{ props.product.description }}
          </div>
          <hr />
          <div class="price row">
            <div class="col-5 text-weight-bold text-h4">
              Your Price:
              <span class="text-h5">{{
                formatter.format(props.product.price)
              }}</span>
            </div>
            <div class="col-7">
              <q-btn unelevated color="amber" @click="addItem" class="q-mr-sm"
                >Add to Cart
              </q-btn>
              <q-btn unelevated color="orange">Buy Now</q-btn>
            </div>
          </div>
        </div>
      </div>
    </div>
  </Layout>
</template>

<script setup>
import Layout from "../../layouts/SiteLayout.vue";
import { Link } from "@inertiajs/vue3";
import { useCartStore } from "~/entrypoints/stores/index.js";
import { toRaw } from "vue";

const cart = useCartStore();
const props = defineProps({ product: Object });

// Add to cart
function addItem() {
  cart.addItem(toRaw(props.product));
}

// Create our number formatter.
const formatter = new Intl.NumberFormat("en-US", {
  style: "currency",
  currency: "USD",

  // These options are needed to round to whole numbers if that's what you want.
  //minimumFractionDigits: 0, // (this suffices for whole numbers, but will print 2500.10 as $2,500.1)
  //maximumFractionDigits: 0, // (causes 2500.99 to be printed as $2,501)
});
</script>

<style scoped>
.description {
  min-height: 300px;
}
</style>
