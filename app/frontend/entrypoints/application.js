import { createApp, h } from "vue";
import { createInertiaApp } from "@inertiajs/vue3";
import { Quasar, Notify } from "quasar";
import { createPinia } from "pinia";

// Import icon libraries
import "@quasar/extras/material-icons/material-icons.css";

// Import Quasar css
import "quasar/src/css/index.sass";

createInertiaApp({
  resolve: (name) => {
    const pages = import.meta.glob("./Pages/**/*.vue", { eager: true });
    return pages[`./Pages/${name}.vue`];
  },
  setup({ el, App, props, plugin }) {
    const pinia = createPinia();
    createApp({ render: () => h(App, props) })
      .use(plugin)
      .use(Quasar, { plugins: { Notify } })
      .use(pinia)
      .mount(el);
  },
});
