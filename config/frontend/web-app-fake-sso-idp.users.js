const users = [
    {
        id: "1",
        name: "John Doe",
        username: "john.doe",
        password: "My ultra secret password that only I know",
        attributes: {
            userId: {
                format: "urn:oasis:names:tc:SAML:2.0:attrname-format:basic",
                type: "xs:string",
                value: "8f7e5a43-ca9e-4b53-8a52-07f157afc23b",
            },
            username: {
                format: "urn:oasis:names:tc:SAML:2.0:attrname-format:basic",
                type: "xs:string",
                value: "john.doe",
            },
            givenName: {
                format: "urn:oasis:names:tc:SAML:2.0:attrname-format:basic",
                type: "xs:string",
                value: "John",
            },
            sn: {
                format: "urn:oasis:names:tc:SAML:2.0:attrname-format:basic",
                type: "xs:string",
                value: "Doe",
            },
            email: {
                format: "urn:oasis:names:tc:SAML:2.0:attrname-format:basic",
                type: "xs:string",
                value: "john.doe@example.com",
            },
            "urn:oid:0.9.2342.19200300.100.1.1": {
                format: "urn:oasis:names:tc:SAML:2.0:attrname-format:basic",
                type: "xs:string",
                value: "john.doe",
            },
            groups: {
                format: "urn:oasis:names:tc:SAML:2.0:attrname-format:basic",
                type: "xs:string",
                value: "draken_ks_admin",
            },
        },
    },
    {
        id: "2",
        name: "Jane Doe",
        username: "jane.doe",
        password: "password123",
        attributes: {
            userId: {
                format: "urn:oasis:names:tc:SAML:2.0:attrname-format:basic",
                type: "xs:string",
                value: "f5a9c357-e58f-49ef-a1db-1f3fcd580d32",
            },
            username: {
                format: "urn:oasis:names:tc:SAML:2.0:attrname-format:basic",
                type: "xs:string",
                value: "jane.doe",
            },
            givenName: {
                format: "urn:oasis:names:tc:SAML:2.0:attrname-format:basic",
                type: "xs:string",
                value: "Jane",
            },
            sn: {
                format: "urn:oasis:names:tc:SAML:2.0:attrname-format:basic",
                type: "xs:string",
                value: "Doe",
            },
            email: {
                format: "urn:oasis:names:tc:SAML:2.0:attrname-format:basic",
                type: "xs:string",
                value: "jane.doe@example.com",
            },
            "urn:oid:0.9.2342.19200300.100.1.1": {
                format: "urn:oasis:names:tc:SAML:2.0:attrname-format:basic",
                type: "xs:string",
                value: "jane.doe",
            },
            groups: {
                format: "urn:oasis:names:tc:SAML:2.0:attrname-format:basic",
                type: "xs:string",
                value: "draken_ks_admin",
            },
        },
    },
];

module.exports = { users };
