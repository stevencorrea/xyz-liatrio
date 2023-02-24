# Design Considerations

I designed this project to be quick to deploy, simple to operate and easy to understand.

This is a full environment and app deploy that I feel meets the requirements of the project in one of the most simple ways I can think of. 

The prompt mentions that XYZ is a traditional on prem shop that is interested in moving to the cloud. I know that moves like these can be difficult, not only for the business but more so the Admins and Engineers that are used to operating on prem.

With that in mind, I added a lot of documentation, reference reading and hints in comments to get an environment off the ground. I needed all of these resources myself as it has been a few years since I have dove deep into Azure.

I also designed the (very) high level architecture diagram to be consumed by non-technical folk. The GH Action runner is applying the k8s manifest which is then reaching out to ACR for the image etc.