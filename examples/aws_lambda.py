from langchain import OpenAI
from langchain.agents import load_tools, AgentType
from langchain.agents import initialize_agent
from langchain.agents.tools import Tool
from langchain.utilities.awslambda import LambdaWrapper
from dotenv import load_dotenv

load_dotenv()

llm = OpenAI(temperature=0)

def get_lambda_tool(**kwargs) -> Tool:
    return Tool(
        name=kwargs["awslambda_tool_name"],
        description=kwargs["awslambda_tool_description"],
        func=LambdaWrapper(**kwargs).run,
    )


tool1 = get_lambda_tool(
    awslambda_tool_name="say-hello",
    awslambda_tool_description="say hello response from aws lambda function",
    function_name="sayHelloLambda"
)

tool2 = get_lambda_tool(
    awslambda_tool_name="say-hello-injapanese",
    awslambda_tool_description="say japanese hello response from aws lambda function",
    function_name="sayHelloLambdaInJapanese"
)


agent = initialize_agent([tool1, tool2], llm, agent=AgentType.ZERO_SHOT_REACT_DESCRIPTION, verbose=True)

agent.run("say hello Lambda!")
agent.run("こんにちわ!")