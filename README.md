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
   yarn add @vitejs/plugin-vue @inertiajs/vue3 vue
   ```
5. Replace the app/frontend/entrypoints/application.js with the following:
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
6. Create "Pages" directory under app/frontend

   All vue folder/pages and layouts go under the Pages directory
   ```bash
   inertiaRails> mkdir app/frontend/Pages
   ```
7. Update database connection info

   `config/database.yml`


8. Run Install gems and setup databases
   ```bash
   ./bin/setup
   ```


