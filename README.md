# Force DDD

This repository presents how to apply Domain Driven Design principles on Salesforce Platform.

## Presentation

https://docs.google.com/presentation/d/1WEdQpqmoI7zKm3rqJ19jf5hwtJpLlWNWscIotFZhpvA/edit?usp=sharing

## Build steps

1. Create scratch org

`sfdx force:org:create -f config/project-scratch-def.json -a <ORG_ALIAS> --durationdays 30 --setdefaultusername`

2. Push the code

`sfdx force:source:push`