import { defineStore } from "pinia";

export const useCartStore = defineStore("cart", {
  state: () => ({ items: [], itemsTotal: 0 }),
  getters: {
    cartItems: (state) => {
      return state.items;
    },
    cartItemCount: (state) => {
      return state.items.length;
    },
  },
  actions: {
    addItem(item) {
      // Add cart id

      this.items.push(item);
      this.itemsTotal = this.itemsTotal + item.price;
    },
    removeItem(itemToRemove) {
      this.items = this.items.filter(
        (item) => item.cartId !== itemToRemove.cartId,
      );
      this.itemsTotal = this.itemsTotal - itemToRemove.price;
    },
  },
});
