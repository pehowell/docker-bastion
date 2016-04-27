FROM alpine:latest
ADD https://github.com/pehowell.keys /home/pehowell/.ssh/authorized_keys
ENV TERM screen-256color
RUN apk add --update coreutils tmux git curl fish bash mosh-server openssh && \
    echo -e "Port 22\n" >> /etc/ssh/sshd_config && \
    cp -a /etc/ssh /etc/ssh.cache && \
    rm -rf /var/cache/apk/* && \
    echo "/usr/bin/fish" >> /etc/shells && \
    passwd -d root && \
    adduser -D -s /usr/bin/fish pehowell && \
    passwd -u pehowell && \
    chown -R pehowell:pehowell /home/pehowell

EXPOSE 22

COPY entry.sh /entry.sh

ENTRYPOINT ["/entry.sh"]

CMD ["/usr/sbin/sshd", "-D", "-f", "/etc/ssh/sshd_config"]
