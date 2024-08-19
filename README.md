# InertiaJS on Rails with Vue & Quasar

<!-- TOC -->

* [InertiaJS on Rails with Vue & Quasar](#inertiajs-on-rails-with-vue--quasar)
    * [Getting the project started using rails 7](#getting-the-project-started-using-rails-7)
    * [This will skip turbolinks, use a postgresql database and set webpack for Vue](#this-will-skip-turbolinks-use-a-postgresql-database-and-set-webpack-for-vue)
    * [Add InertiaJS gem to the project](#add-inertiajs-gem-to-the-project)
    * [Add Vite](#add-vite)
    * [Add Vite, Vue and Quasar packages - Quasar optional(@quasar/vite-plugin @quasar/extras sass)](#add-vite-vue-and-quasar-packages---quasar-optionalquasarvite-plugin-quasarextras-sass)
    * [Replace the app/frontend/entrypoints/application.js with the following:](#replace-the-appfrontendentrypointsapplicationjs-with-the-following)
    * [Create "Pages" directory under app/frontend/entrypoint](#create-pages-directory-under-appfrontendentrypoint)
    * [(Optional) Configure @quasar-vite-plugin](#optional-configure-quasar-vite-plugin)
    * [Update database connection info](#update-database-connection-info)
    * [Run Install gems and setup databases](#run-install-gems-and-setup-databases)
    * [References](#references)
    * [Running the app](#running-the-app)
        * [Start the Rails server](#start-the-rails-server)
        * [Start the Vite server for javascript](#start-the-vite-server-for-javascript)

<!-- TOC -->

# Overview

Project goals:

- Validate ease of use communicating between rails controller and Vue page
- Validate Quasar can work in the stack
- Validate Pinia can be used in the stack
- Validate vite_rails as a replacement for webpacker

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

### Add Vite, Vue and Quasar packages - Quasar optional(@quasar/vite-plugin @quasar/extras sass)

   ```bash
   yarn add @vitejs/plugin-vue @inertiajs/vue3 @quasar/vite-plugin @quasar/extras sass vue
   ```

### Replace the app/frontend/entrypoints/application.js with the following:

   ```javascript
   import {createApp, h} from 'vue'
import {createInertiaApp} from '@inertiajs/vue3'

createInertiaApp({
    resolve: name => {
        const pages = import.meta.glob('./Pages/**/*.vue', {eager: true})
        return pages[`./Pages/${name}.vue`]
    },
    setup({el, App, props, plugin}) {
        createApp({render: () => h(App, props)})
            .use(plugin)
            .mount(el)
    },
})
   ```

### Create "Pages" directory under app/frontend/entrypoint

All vue folder/pages and layouts go under the Pages directory

   ```bash
   inertiaRails> mkdir app/frontend/entrypoint/Pages
   ```

### (Optional) Configure @quasar-vite-plugin

[Quasar Vite Plugin Configuration Page](https://quasar.dev/start/vite-plugin)

### Update database connection info

   ```
   config/database.yml
   ```

### Run Install gems and setup databases

   ```bash
   ./bin/setup
   ```

## References

- [vite-ruby](https://vite-ruby.netlify.app/)
- [@quasar/vite-plugin](https://quasar.dev/start/vite-plugin/)
- [inertiajs](https://inertiajs.com/)
- [inertia-rails](https://github.com/inertiajs/inertia-rails)

## Running the app

### Start the Rails server

```bash 
rails s
```

### Start the Vite server for javascript

```bash 
vite dev
```

