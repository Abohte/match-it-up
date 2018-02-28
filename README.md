# Match It Up

Simple Rails app made together with [Sebastian van Hesteren](https://github.com/svanhesteren) during week 4 of the 9-week Codaisseur Academy.

### Assignment
Create an app in charge of making daily matches of two students (or three, in case of an odd number of students) within a class.

#### Requirements:
Pairs are not matched with the same person twice until he/she has been matched with all the registered students. In case of a change in the students pool, the progression is not set. In this project, we opted to start afresh with the possible matches whenever the students pool is mutated.

The following User Stories were kept in mind:

##### As an Admin...
- I need to sign in before having access to any page in the application.
- I have an overview of the matches for each day.
- I can auto-generate matches for a specific day (provided there are no matches generated for that day).
- I can see a list of all Users of the application and with a single click of a button promote a User to Admin, or demote a User to Student.

##### As a Student...
- I need to signup/register.
- I need to sign in before having access to any page in the application.
- after signing in, I can see my "match" for the current day.
- my "match" is calculated randomly among all the registered Students until that moment.
- I am matched to another Student, but only once each day.
- I can see my matches for the past days, but not for future days.

<kbd>
  <img src="/app/assets/images/AdminMatchPage.png">
</kbd>
<kbd>
  <img src="/app/assets/images/AdminUserPage.png">
</kbd>
<kbd>
  <img src="/app/assets/images/StudentMatchPage.png">
</kbd>


## Steps

While working on this app we followed these steps:

1. Setting up project with Rails and PostgreSQL.
2. Adding Bootstrap, jQuery, Devise, RSpec, FactoryBot.
3. Creating models and associations.
4. Creating matching algorithm.
5. Setting up controllers and views.
6. Add AJAX for admin toggle and generate matches.
7. Generate new matches for today (if not yet present) upon Student login.

## Database Structure

#### Users
  * email:string
  * password:string
  * first_name:string
  * last_name:string
  * admin:boolean

#### Matches
  * user_id:bigint
  * pair_id:bigint

#### Pairs
  * date:date

#### pairing_progresses
  * current_students_order:array
  * current_iteration:integer

## Running Locally

Make sure you have [Ruby](https://www.ruby-lang.org/en/) and [Bundler](http://bundler.io/) installed.

```bash
git clone git@github.com:Abohte/match-it-up.git
cd match-it-up
bundle install
rails db:create db:migrate db:seed
rails server
```
