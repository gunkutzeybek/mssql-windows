FROM microsoft/mssql-server-windows-developer

LABEL maintainer "Gunkut Zeybek"
LABEL description "This is the exact same image with microsoft/mssql-server-windows-developer image except adding a login and user functionalities."

ENV sa_password="_" \
    attach_dbs="[]" \
    ACCEPT_EULA="_" \
    sa_password_path="C:\ProgramData\Docker\secrets\sa-password"

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

# make install files accessible
# start_with_user powershell script is a slightly modified version of https://github.com/Microsoft/mssql-docker/blob/master/windows/mssql-server-windows-developer/start.ps1
COPY start_with_user.ps1 /
COPY create_login_and_user.sql /
WORKDIR /

HEALTHCHECK CMD [ "sqlcmd", "-Q", "select 1" ]

CMD .\start_with_user -sa_password $env:sa_password -ACCEPT_EULA $env:ACCEPT_EULA -attach_dbs \"$env:attach_dbs\" -Verbose


