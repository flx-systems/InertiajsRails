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
      this.items.push(item);
      this.itemsTotal = this.itemsTotal + item.price;
    },
    removeItem(item) {
      this.items = this.items.filter((item) => item.id !== item.id);
      this.itemsTotal = this.itemsTotal - item.price;
    },
  },
});
