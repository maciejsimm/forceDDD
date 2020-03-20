# Force DDD

This repository presents our idea on how to apply Domain Driven Design principles on Salesforce Platform.

Please note this is work-in-progress :-)

Feel free to comment & collaborate!


Build by @enxooteam members:

@maciejsimm, Konrad Karaś and others

## Presentation

https://drive.google.com/file/d/13YTFm4_9A-S1z8-VGkXr2i29IgmkdKyY/view?usp=sharing

#### London's Calling 2020 Presentation Recording

link to be provided soon

## Build steps

1. Create scratch org

`sfdx force:org:create -f config/project-scratch-def.json -a <ORG_ALIAS> --durationdays 30 --setdefaultusername`

2. Push the code

`sfdx force:source:push`

## Sample implementation code

Take a look at force-ddd/assetManagementExample/module_assetMgmt