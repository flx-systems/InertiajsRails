import { defineConfig } from "vite";
import RubyPlugin from "vite-plugin-ruby";
import vue from "@vitejs/plugin-vue";
import { quasar, transformAssetUrls } from "@quasar/vite-plugin";

export default defineConfig({
  plugins: [
    RubyPlugin(),
    vue({
      template: { transformAssetUrls },
    }),
    // @quasar/plugin-vite options list:
    // https://github.com/quasarframework/quasar/blob/dev/vite-plugin/index.d.ts
    quasar({
      sassVariables: "app/frontend/entrypoints/quasar-variables.sass",
    }),
  ],
});
