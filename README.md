# InertiaJS on Rails

### Getting the project started using rails 7
### This will skip turbolinks, use a postgresql database and set webpack for Vue
   ```bash
   rails new inertiaRails -d postgresql --skip-javascript --skip-asset-pipeline
   ```
### Add InertiaJS gem to the project
   ```bash
   bundle add inertia_rails
   ```
### Add Vite

   ```bash
   bundle add vite_rails
   ```
   ```bash 
   bundle exec vite install
   ```
### Add Vite, Vue and Quasar packages
   ```bash
   yarn add @vitejs/plugin-vue @inertiajs/vue3 @quasar/vite-plugin @quasar/extras sass vue
   ```
### Replace the app/frontend/entrypoints/application.js with the following:
   ```javascript
   import { createApp, h } from 'vue'
   import { createInertiaApp } from '@inertiajs/vue3'

   createInertiaApp({
     resolve: name => {
       const pages = import.meta.glob('./pages/**/*.vue', { eager: true })
       return pages[`./Pages/${name}.vue`]
     },
     setup({ el, App, props, plugin }) {
       createApp({ render: () => h(App, props) })
       .use(plugin)
       .mount(el)
     },
   })
   ```
### Create "Pages" directory under app/frontend

   All vue folder/pages and layouts go under the Pages directory
   ```bash
   inertiaRails> mkdir app/frontend/pages
   ```
### Configure @quasar-vite-plugin 
[Quasar Vite Plugin Configuration Page](https://quasar.dev/start/vite-plugin)

### Update database connection info

   ```
   config/database.yml
   ```

### Run Install gems and setup databases
   ```bash
   ./bin/setup
   ```
## Running the app

### Start the Rails server
```bash 
rails s
```
### Start the Vite server for javascript
```bash 
vite dev
```

