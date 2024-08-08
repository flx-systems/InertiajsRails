# InertiaJS on Rails

### Getting the project started using rails 7
1. This will skip turbolinks, use a postgresql database and set webpack for vue
   ```bash
   rails new inertiaRails -d postgresql --skip-javascript --skip-asset-pipeline
   ```
2. Add InertiaJS gem to the project
   ```bash
   bundle add inertia_rails
   ```
3. Add Vite

   ```bash
   bundle add vite_rails
   ```
   ```bash 
   bundle exec vite install
   ```
4. Add vue/vite packages
   ```bash
   yarn add @vitejs/plugin-vue @inertiajs/vue3
   ```
5. Replace the app/frontend/entrypoints/application.js following:
   ```javascript
   import { createApp, h } from 'vue'
   import { createInertiaApp } from '@inertiajs/vue3'

   createInertiaApp({
     resolve: name => {
       const pages = import.meta.glob('./Pages/**/*.vue', { eager: true })
       return pages[`./Pages/${name}.vue`]
     },
     setup({ el, App, props, plugin }) {
       createApp({ render: () => h(App, props) })
       .use(plugin)
       .mount(el)
     },
   })
   ```
6. Update database connection info

   `config/database.yml`


7. Run Install gems and setup databases
   ```bash
   ./bin/setup
   ```


