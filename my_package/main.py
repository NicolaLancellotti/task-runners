import asyncio

from my_package import subprocesses
from my_package.arguments import Arguments


async def run_command() -> None:
    arg = "."
    command = """
    ls -l {file_name}
    """.format(
        file_name=subprocesses.quote(arg)
    )
    await subprocesses.run(command=command, log_command=False)


# _____________________________________________________________________________
# Main


def main() -> None:
    Arguments.parse()
    print(f"value = {Arguments.value()}")

    if Arguments.list_directory():
        loop = asyncio.get_event_loop()
        loop.run_until_complete(run_command())
