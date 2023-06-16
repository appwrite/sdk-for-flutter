final routes = [
  {
    "method": "get",
    "path": "\/account",
    "offline": {
      "model": "\/account",
      "key": "current",
      "response-key": "\$id",
      "container-key": "",
    },
  },
  {
    "method": "post",
    "path": "\/account\/sessions\/email",
    "offline": {
      "model": "",
      "key": "",
      "response-key": "\$id",
      "container-key": "",
    },
  },
  {
    "method": "get",
    "path": "\/databases\/{databaseId}\/collections\/{collectionId}\/documents",
    "offline": {
      "model":
          "\/databases\/{databaseId}\/collections\/{collectionId}\/documents",
      "key": "",
      "response-key": "\$id",
      "container-key": "documents",
    },
  },
  {
    "method": "post",
    "path": "\/databases\/{databaseId}\/collections\/{collectionId}\/documents",
    "offline": {
      "model":
          "\/databases\/{databaseId}\/collections\/{collectionId}\/documents",
      "key": "",
      "response-key": "\$id",
      "container-key": "",
    },
  },
  {
    "method": "get",
    "path":
        "\/databases\/{databaseId}\/collections\/{collectionId}\/documents\/{documentId}",
    "offline": {
      "model":
          "\/databases\/{databaseId}\/collections\/{collectionId}\/documents",
      "key": "{documentId}",
      "response-key": "\$id",
      "container-key": "",
    },
  },
  {
    "method": "patch",
    "path":
        "\/databases\/{databaseId}\/collections\/{collectionId}\/documents\/{documentId}",
    "offline": {
      "model":
          "\/databases\/{databaseId}\/collections\/{collectionId}\/documents",
      "key": "{documentId}",
      "response-key": "\$id",
      "container-key": "",
    },
  },
  {
    "method": "delete",
    "path":
        "\/databases\/{databaseId}\/collections\/{collectionId}\/documents\/{documentId}",
    "offline": {
      "model":
          "\/databases\/{databaseId}\/collections\/{collectionId}\/documents",
      "key": "{documentId}",
      "response-key": "\$id",
      "container-key": "",
    },
  }
];
