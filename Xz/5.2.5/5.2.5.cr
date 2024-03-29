class Target < ISM::Software

    def configure
        super

        if option("Pass1")
            configureSource([   "--prefix=/usr",
                                "--host=#{Ism.settings.chrootTarget}",
                                "--build=$(build-aux/config.guess)",
                                "--disable-static",
                                "--docdir=/usr/share/doc/xz-5.2.5"],
                                buildDirectoryPath)
        else
            configureSource([   "--prefix=/usr",
                                "--disable-static",
                                "--docdir=/usr/share/doc/xz-5.2.5"],
                                buildDirectoryPath)
        end
    end

    def build
        super

        makeSource(path: buildDirectoryPath)
    end

    def prepareInstallation
        super

        makeSource(["DESTDIR=#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}","install"],buildDirectoryPath)
    end

end
