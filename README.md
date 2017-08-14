# HTTP redirect spreadsheet to nginx

Problem: A digital agency insisted on delivering a web site using a custom
Django CMS, so we can't use the normal Wordpress plugin for setting up redirects
for URLs from the old site.

Solution: A Ruby script for transforming our spreadsheet of redirects into nginx
redirects.

## Input data

This script expects an Excel .xlsx spreadsheet with the redirects in the first
sheet.  It expects to find the original URLs in a column titled, "old URL", and
the new URLs in a column titled "new URL".

## Running

### Step 1: (Optional) Install RVM

https://rvm.io/rvm/install

You might like to run Ruby in some other way.  Have fun with that.

### Step 2: Install Ruby

I used 2.4 and that's recorded in the .rvmrc file.  Any 2.x version will
probably work.

### Step 3: Install Bundler

    gem install bundler

### Step 4: Install gem bundle

    bundle install

### Step 5: Run the script

    ruby transform.rb spreadsheet.xlsx
