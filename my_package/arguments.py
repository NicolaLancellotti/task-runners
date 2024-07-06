import argparse

from my_package.config import Config


class Arguments:
    _args: argparse.Namespace

    @staticmethod
    def parse() -> None:
        parser = argparse.ArgumentParser(
            prog=f"python3 -m {Config.package_name}",
            description="",
            epilog="""
    DESCRIPTION
            """,
        )
        parser.add_argument(
            "-ls",
            "--list-directory",
            action="store_true",
            help="help message",
            required=False,
        )
        parser.add_argument("-n", "--number", default=0, type=int, help="help message")
        parser.add_argument(
            "-v",
            "--value",
            choices=[
                "A",
                "B",
            ],
            default="A",
            help="help message",
        )
        Arguments._configure_argcomplete(parser=parser)
        Arguments._args = parser.parse_args()

    @staticmethod
    def value() -> str:
        return Arguments._args.value

    @staticmethod
    def list_directory() -> str:
        return Arguments._args.list_directory

    @staticmethod
    def _configure_argcomplete(parser: argparse.ArgumentParser) -> None:
        # TODO
        #!/usr/bin/env python3
        # PYTHON_ARGCOMPLETE_OK
        try:
            import argcomplete  # type: ignore

            argcomplete.autocomplete(parser)  # type: ignore
        except:
            pass
        pass
