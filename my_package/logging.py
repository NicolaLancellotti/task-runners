import logging

from my_package.config import Config


def make_logger(name: str) -> logging.Logger:
    logFormatter = logging.Formatter(
        fmt="%(asctime)s %(name)-8s %(levelname)-8s %(message)s",
        datefmt="%Y-%m-%d %H:%M:%S",
    )

    fileHandler = logging.FileHandler(filename=Config.derived_data / "log.log")
    fileHandler.setFormatter(logFormatter)

    logger = logging.getLogger(name)
    logger.setLevel(logging.INFO)
    logger.addHandler(fileHandler)
    return logger
