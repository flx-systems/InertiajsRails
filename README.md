# InertiaJS on Rails

### Getting the project started using rails 7
1. This will skip turbolinks, use a postgresql database and set webpack for vue

   ```rails new inertiaRails -d postgresql --skip-javascript --skip-asset-pipeline```


2. Add InertiaJS gem to the project

   ```bundle add inertia_rails```


3. Add Vite

   ```bundle add vite_rails```


4. Update database connection info

   ```config/database.yml```


5. Run Install gems and setup databases

   ```./bin/setup```


6. 