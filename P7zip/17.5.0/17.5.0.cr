class Target < ISM::Software

    def build
        super

        makeSource( arguments:  "all3",
                    path:       buildDirectoryPath)
    end

    def prepareInstallation
        super

        makeSource( arguments:  "DEST_DIR=#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath} DEST_HOME=/usr DEST_MAN=/usr/share/man DEST_SHARE_DOC=/usr/share/doc/p7zip-17.05 install",
                    path:       buildDirectoryPath)
    end

end
