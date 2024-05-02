FROM python:3.12
LABEL maintainer='abc@gmail.com'

WORKDIR /code 

RUN pip install poetry

RUN poetry config virtualenvs.create false

# Copy the pyproject.toml and possibly poetry.lock files first to install dependencies
COPY pyproject.toml /code/

# Assuming your pyproject.toml and the whole docker_compose directory are at the same level in your project
COPY ./compose /code/compose

RUN poetry install

CMD ["poetry", "run", "uvicorn", "compose.main:app", "--host", "0.0.0.0", "--port", "8000"]
