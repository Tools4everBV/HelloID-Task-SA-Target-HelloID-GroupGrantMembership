# HelloID-Task-SA-Target-HelloID-GroupGrantMembership

<a href="https://github.com/Tools4everBV/HelloID-Task-SA-Target-HelloID-GroupGrantMembership/network/members"><img src="https://img.shields.io/github/forks/Tools4everBV/HelloID-Task-SA-Target-HelloID-GroupGrantMembership" alt="Forks Badge"/></a>
<a href="https://github.com/Tools4everBV/HelloID-Task-SA-Target-HelloID-GroupGrantMembership/pulls"><img src="https://img.shields.io/github/issues-pr/Tools4everBV/HelloID-Task-SA-Target-HelloID-GroupGrantMembership" alt="Pull Requests Badge"/></a>
<a href="https://github.com/Tools4everBV/HelloID-Task-SA-Target-HelloID-GroupGrantMembership/issues"><img src="https://img.shields.io/github/issues/Tools4everBV/HelloID-Task-SA-Target-HelloID-GroupGrantMembership" alt="Issues Badge"/></a>
<a href="https://github.com/Tools4everBV/HelloID-Task-SA-Target-HelloID-GroupGrantMembership/graphs/contributors"><img alt="GitHub contributors" src="https://img.shields.io/github/contributors/Tools4everBV/HelloID-Task-SA-Target-HelloID-GroupGrantMembership?color=2b9348"></a>

## Prerequisites
- [ ] HelloID API key and secret
- [ ] Pre-defined variables: `portalBaseUrl`, `portalApiKey` and `portalApiSecret` created in your HelloID portal.

## Description
This code snippet will add an existing group to an existing group within HelloID and executes the following tasks:

1. Define a hash table `$formObject`. The keys of the hash table represent the properties necessary to add an existing group to an existing group within `HelloID`, while the values represent the values entered in the form.

> To view an example of the form output, please refer to the JSON code pasted below.

```json
{
    "groupToAddGUID": "9f2c94e5a-7881-455a-a727-3fafd9d926e0",
    "groupToAddName": "John Doe's group To Add",
    "groupGUID": "9509133d-8ae4-48bf-a2cb-e0f31cae4deb",
    "groupName": "John Doe's group"
}
```

> :exclamation: It is important to note that the names of your form fields might differ. Ensure that the `$formObject` hash table is appropriately adjusted to match your form fields.
> [See the HelloID API Docs page](https://apidocs.helloid.com/docs/helloid/7ae11d9ebccc2-link-a-group-to-a-group)

2. Creates authorization headers using the provided API key and secret.

3. add an existing group to an existing group using the: `Invoke-RestMethod` cmdlet. The hash table called: `$formObject` is passed to the body of the: `Invoke-RestMethod` cmdlet as a JSON object.
