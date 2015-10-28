Rails Webpack
=============

[![Code Climate](https://codeclimate.com/github/astral1/rails-webpack/badges/gpa.svg)](https://codeclimate.com/github/astral1/rails-webpack)

Rails에서 Webpack과 Gulp 조합을 사용하기 위한 소소한 보조 라이브러리.

Install
-------

```
gem install rails-webpack -v '0.2.2'
```

혹은 Bundler를 이용할 경우

Gemfile에 아래 추가후, `bundle install`
```
gem 'rails-webpack', '~> 0.2', '>= 0.2.2'
```

Usage
-----

### 사전 설정

- node
- npm

은 자동으로 설치되지 않는다.

`app/webpack`에 설정과 의존성이 들어간다. 빌드된 최종 결과물은 `app/assets/compiled`에 저장

### 초기 설정

```
rails generate webpack:config
```

config/webpack.yml 이 없다면 생성되나 이미 있다면 여러번 실행하더라도 설정파일을 더이상 변경하지 않는다.

### 샘플 설정

```
---
main: 'common.js'
version: '1.0.0'
description: 'FIXME: <%= Rails.application.class.parent.name.underscore.gsub('/', '-') %>'
#homepage: 'https://github.com/astral1/rails-webpack'
license: 'MIT'
authors:
  - name: '<%= `git config user.name`.strip %>'
    email: '<%= `git config user.email`.strip %>'
gulp:
  default:
    - 'webpack'
  tasks:
    - name: 'webpack'
      dependencies:
        - 'bower'
bower:
  dependencies: []
npm:
#  repoistory:
#    type: 'git'
#    url: 'git+ssh://git@github.com/astral1/rails-webpack.git'
#  keywords:
#    - webpack
#    - rails
  dependencies: []
  develop_dependencies:
    - name: 'coffee-loader'
      version: '~0.7'
    - name: 'less-loader'
      version: '~2.2'
    - name: 'style-loader'
      version: '~0.12'
    - name: 'css-loader'
      version: '~0.17'
    - name: 'vinyl-named'
      version: '~1.1'
    - name: 'webpack'
      version: '~1.12'
    - name: 'webpack-stream'
      version: '~2.1'
    - name: 'bower'
      version: '~1.4'
    - name: 'gulp'
      version: '~3.8.11'
    - name: 'gulp-util'
      version: '~3.0.4'
    - name: 'gulp-bower'
      version: '~0.0.10'
    - name: 'gulp-zip'
      version: '~3.0.2'
    - name: 'gulp-load-plugins'
      version: '1.0.0-rc.1'
    - name: 'walk-sync'
      version: '~0.2.5'
```

- main - `package.json`의 main 값을 설정한다.
- version - resource package의 버전 asset pipeline의 버전도 여기에 맞춰진다.
- descriptsion - `package.json`과 `bower.json`에 포함될 resource package에 대한 설명
- homepage - resource-package의 주소 없어도 무방하다. 설정된다면, `package.json`, `bower.json`에 영향을 준다.
- license - script에 대한 License. 기본값은 MIT
- authors - script 작성자 정보. 기본으로 git user 정보를 이용해 설정된다.

#### Gulp 설정

- gulp.default - gulp의 기본 태스크
- gulp.tasks - gulp의 작업 의존성 설정 

#### Bower 설정

- dependencies - Bower의 패키지 의존성 설정 Hash List 형태로 아래의 자료구조대로 작성한다.
```
[{name: 'flight', version: '~ 1.5'}, {name: 'q', version: '~ 1.4.1'}]
```

#### NPM 설정

- repoistory - 소스 확인 가능한 VCS 저장소 위치
- keyword - npm package를 위한 키워드
- dependencies - 운영에 필요한 의존성 목록 작성 규칙은 `bower.dependencies`와 동일
- develop_dependencies - 개발을 위한 의존성 목록 주로 gulp와 webpack을 위한 의존성 목록

### 설치

```
rails generator webpack:install
```

### 추가 명령

#### 동기화

```
rake webpack:sync
```

`webpack.yml`의 변경분을 반영한다.

#### Rake

- `rake gulp:webpack` - gulp로 webpack 태스크 실행
- `rake gulp:bower` - gulp로 bower 태스크 실행
- `rake npm:install` - npm 패키지 설치
- `rake npm:clean` - npm으로 설치된 패키지 모두 삭제
- `rake npm:install:clean` - 기존 의존성을 모두 삭제한 후 재설치
- `rake prepare:webpack` - Webpack 작업 실행. `assets:precompile`이 실행될 때 함께 실행된다.
- `rake webpack:init` - 기본 레이아웃 작성. intializer, default script, page script등

TO DOs
------

- 의존성에 대한 버전 머지기능 지원(현재는 버전스펙까지 동일해야만 정리됨)

License
-------

MIT 라이센스를 따르며, 상세한 사항은 LICENSE 파일 참조
