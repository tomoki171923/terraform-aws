<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**

- [terraform lambda module](#terraform-lambda-module)
  - [deploy](#deploy)
    - [development environment](#development-environment)
    - [production environment](#production-environment)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

# terraform lambda module

## deploy

### development environment
~~~
% tf apply

var.alias
  Please select lambda alias between [dev, st, pro].

  Enter a value: dev
~~~

### production environment

~~~
% tf apply

var.alias
  Please select lambda alias between [dev, st, pro].

  Enter a value: pro
~~~