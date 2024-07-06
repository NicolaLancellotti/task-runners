import asyncio
import shlex

from my_package import logging

logger = logging.make_logger(__name__)


async def run(command: str, log_command: bool = False) -> None:
    if log_command:
        logger.info(f"Command: {command.strip()}")
    await asyncio.create_subprocess_shell(cmd=command)


def quote(string: str) -> str:
    return shlex.quote(string)
