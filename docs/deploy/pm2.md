---
title: PM2
description: Use PM2
meta:
  - name: "og:description"
    content: PM2
  - name: keywords
    content: Plone Volto PM2
tags:
  - Volto
  - Plone
  - Pm2
---

<Header/>

[PM2](https://pm2.keymetrics.io/) is a popular and maintained process manager based in Node.

Create a file mywebsite.com.pm2.config.js in your repo or on your server.

:::warning Info

Make sure your pm2 config file sufix ends in `config.js`, otherwise PM2 will ignore it.

:::

``` js
module.exports = {
  apps: [
     {
       script: "/srv/mywebsite.com/build/server.js",
       name: "mywebsite.com-volto",
       cwd: "/srv/mywebsite.com"
     },
     {
       script: "/srv/mywebsite.com/api/bin/zeo",
       args: "fg",
       name: "mywebsite.com-api-zeo",
       cwd: "/srv/mywebsite.com",
       interpreter: "/srv/mywebsite.com/api/bin/python"
     },
     {
       script: "/srv/mywebsite.com/api/bin/instance1",
       args: "console",
       name: "mywebsite.com-api-instance1",
       cwd: "/srv/mywebsite.com",
       interpreter: "/srv/mywebsite.com/api/bin/python"
     },
     {
       script: "/srv/mywebsite.com/api/bin/instance2",
       args: "console",
       name: "mywebsite.com-api-instance2",
       cwd: "/srv/mywebsite.com",
       interpreter: "/srv/mywebsite.com/api/bin/python"
     }
    ]
};
```

```sh
echo Hello world
````

::: warning
If this command did not publish any files, chances are, the Laratrust service provider hasn't been registered. Try clearing your configuration cache
```bash
php artisan config:clear
```
:::

3. Run the setup command:

::: tip IMPORTANT
**Before running the command go to your* `config/laratrust.php` *file and change the values according to your needs.**
:::

```bash
php artisan laratrust:setup
```

This command will generate the migrations, create the `Role` and `Permission` models (if you are using the teams feature it will also create a `Team` model) and will add the trait to the configured user models.

4. Dump the autoloader:
```bash
composer dump-autoload
```

## Setting things up
Let's start by creating the following `Role`s:

```php
$owner = Role::create([
    'name' => 'owner',
    'display_name' => 'Project Owner', // optional
    'description' => 'User is the owner of a given project', // optional
]);

$admin = Role::create([
    'name' => 'admin',
    'display_name' => 'User Administrator', // optional
    'description' => 'User is allowed to manage and edit other users', // optional
]);
```