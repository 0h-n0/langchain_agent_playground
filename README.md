# Langchain Agent Playground

## requeiremnts
set your openai api key on `.env` file

```bash
OPENAI_API_KEY="hogehogehoge"
```

## AWS Lambda Agent

you need to create lambda functions before tring to AWS lambda agent sample. 

```shell
$ cd terraform
$ terraform apply
```
This command creates two "Say hello" lambda functions, one is a japnaese replay and the another is an english replay.

[How to use aws-cli with terraform](https://docs.aws.amazon.com/ja_jp/serverless-application-model/latest/developerguide/what-is-terraform-support.html)

```shell
$ poetry run python examples/aws_lambda.py 

> Entering new AgentExecutor chain...
 I need to use a tool to say hello
Action: say-hello
Action Input: Lambda
Observation: Result: hello from lambda
Thought: I now know the final answer
Final Answer: Hello from Lambda!

> Finished chain.


> Entering new AgentExecutor chain...
 I need to respond in Japanese
Action: say-hello-injapanese
Action Input: None
Observation: Result: こんにちわ from lambda
Thought: I now know the final answer
Final Answer: こんにちわ

> Finished chain
```

After try to using AWS lambda agent, you need to remove AWS Lambda resources with the follwing command.

```shell
$ cd terraform
$ terraform destory
```